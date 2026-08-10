package main

/** begin hidden */
import (
	"fmt"
	"strings"
)

type CodegenError struct{ Msg string }

func (e *CodegenError) Error() string { return "codegen error: " + e.Msg }

type codegen struct {
	buf      strings.Builder
	offsets  map[string]int
	labelID  int
	prefix   string
	retLabel string
	loops    [][2]string
}

func (g *codegen) emit(format string, a ...any) {
	fmt.Fprintf(&g.buf, format+"\n", a...)
}

func (g *codegen) freshLabel() string {
	l := fmt.Sprintf(".L%s_%d", g.prefix, g.labelID)
	g.labelID++
	return l
}

func (g *codegen) push()          { g.emit("\tstr\tx0, [sp, #-16]!") }
func (g *codegen) pop(reg string) { g.emit("\tldr\t%s, [sp], #16", reg) }

func align16(n int) int { return (n + 15) / 16 * 16 }

func (g *codegen) assignOffsets(params []Param, body Stmt) int {
	next := 0
	alloc := func(name string) {
		next += 8
		g.offsets[name] = -next
	}
	for i, p := range params {
		if i < 8 {
			alloc(p.Name)
		} else {
			g.offsets[p.Name] = 16 + 8*(i-8)
		}
	}
	var scan func(Stmt)
	scan = func(s Stmt) {
		switch st := s.(type) {
		case *Compound:
			for _, d := range st.Decls {
				alloc(d.Name)
			}
			for _, x := range st.Stmts {
				scan(x)
			}
		case *IfStmt:
			scan(st.Then)
			if st.Else != nil {
				scan(st.Else)
			}
		case *WhileStmt:
			scan(st.Body)
		}
	}
	scan(body)
	return align16(next)
}

func (g *codegen) offsetOf(name string) int {
	off, ok := g.offsets[name]
	if !ok {
		panic(&CodegenError{"undefined variable " + name})
	}
	return off
}

func (g *codegen) genExpr(e Expr) {
	switch x := e.(type) {
	case *IntLit:
		g.emit("\tmov\tx0, #%d", x.Value)
	case *VarRef:
		g.emit("\tldr\tx0, [x29, #%d]", g.offsetOf(x.Name))
	case *Assign:
		v, ok := x.LHS.(*VarRef)
		if !ok {
			panic(&CodegenError{"left-hand side of assignment must be a variable"})
		}
		g.genExpr(x.RHS)
		g.emit("\tstr\tx0, [x29, #%d]", g.offsetOf(v.Name))
	case *Unary:
		g.genExpr(x.E)
		switch x.Op {
		case OpPos:
		case OpNeg:
			g.emit("\tneg\tx0, x0")
		case OpBNot:
			g.emit("\tmvn\tx0, x0")
		case OpLNot:
			g.emit("\tcmp\tx0, #0")
			g.emit("\tcset\tx0, eq")
		}
	case *Binary:
		g.genExpr(x.L)
		g.push()
		g.genExpr(x.R)
		g.pop("x1")
		switch x.Op {
		case OpAdd:
			g.emit("\tadd\tx0, x1, x0")
		case OpSub:
			g.emit("\tsub\tx0, x1, x0")
		case OpMul:
			g.emit("\tmul\tx0, x1, x0")
		case OpDiv:
			g.emit("\tsdiv\tx0, x1, x0")
		case OpMod:
			g.emit("\tsdiv\tx2, x1, x0")
			g.emit("\tmsub\tx0, x2, x0, x1")
		case OpLt:
			g.cmpSet("lt")
		case OpGt:
			g.cmpSet("gt")
		case OpLe:
			g.cmpSet("le")
		case OpGe:
			g.cmpSet("ge")
		case OpEq:
			g.cmpSet("eq")
		case OpNe:
			g.cmpSet("ne")
		}
	case *Call:
		g.genCall(x)
	}
}

func (g *codegen) cmpSet(cond string) {
	g.emit("\tcmp\tx1, x0")
	g.emit("\tcset\tx0, %s", cond)
}

func (g *codegen) genCall(c *Call) {
	n := len(c.Args)
	k := n
	if k > 8 {
		k = 8
	}
	nstack := n - k
	area := align16(8 * nstack)
	if area > 0 {
		g.emit("\tsub\tsp, sp, #%d", area)
	}
	for i := 0; i < k; i++ {
		g.genExpr(c.Args[i])
		g.push()
	}
	for i := 8; i < n; i++ {
		g.genExpr(c.Args[i])
		g.emit("\tstr\tx0, [sp, #%d]", 16*k+8*(i-8))
	}
	for i := 0; i < k; i++ {
		g.emit("\tldr\tx%d, [sp, #%d]", i, 16*(k-1-i))
	}
	if k > 0 {
		g.emit("\tadd\tsp, sp, #%d", 16*k)
	}
	g.emit("\tbl\t%s", c.Name)
	if area > 0 {
		g.emit("\tadd\tsp, sp, #%d", area)
	}
}

func (g *codegen) genStmt(s Stmt) {
	switch st := s.(type) {
	case *EmptyStmt:
	case *ExprStmt:
		g.genExpr(st.E)
	case *ReturnStmt:
		g.genExpr(st.E)
		g.emit("\tb\t%s", g.retLabel)
	case *Compound:
		for _, x := range st.Stmts {
			g.genStmt(x)
		}
	case *IfStmt:
		lElse := g.freshLabel()
		lEnd := g.freshLabel()
		g.genExpr(st.Cond)
		g.emit("\tcmp\tx0, #0")
		g.emit("\tbeq\t%s", lElse)
		g.genStmt(st.Then)
		g.emit("\tb\t%s", lEnd)
		g.emit("%s:", lElse)
		if st.Else != nil {
			g.genStmt(st.Else)
		}
		g.emit("%s:", lEnd)
	case *WhileStmt:
		lTop := g.freshLabel()
		lEnd := g.freshLabel()
		g.emit("%s:", lTop)
		g.genExpr(st.Cond)
		g.emit("\tcmp\tx0, #0")
		g.emit("\tbeq\t%s", lEnd)
		g.loops = append(g.loops, [2]string{lEnd, lTop})
		g.genStmt(st.Body)
		g.loops = g.loops[:len(g.loops)-1]
		g.emit("\tb\t%s", lTop)
		g.emit("%s:", lEnd)
	case *BreakStmt:
		if len(g.loops) == 0 {
			panic(&CodegenError{"break outside of loop"})
		}
		g.emit("\tb\t%s", g.loops[len(g.loops)-1][0])
	case *ContinueStmt:
		if len(g.loops) == 0 {
			panic(&CodegenError{"continue outside of loop"})
		}
		g.emit("\tb\t%s", g.loops[len(g.loops)-1][1])
	}
}

func (g *codegen) genFun(f *FunDef) {
	g.offsets = map[string]int{}
	g.labelID = 0
	g.prefix = f.Name
	g.retLabel = ".Lret_" + f.Name
	g.loops = nil
	frame := g.assignOffsets(f.Params, f.Body)

	g.emit("\t.text")
	g.emit("\t.global\t%s", f.Name)
	g.emit("%s:", f.Name)
	g.emit("\tstp\tx29, x30, [sp, #-16]!")
	g.emit("\tmov\tx29, sp")
	if frame > 0 {
		g.emit("\tsub\tsp, sp, #%d", frame)
	}
	for i, p := range f.Params {
		if i < 8 {
			g.emit("\tstr\tx%d, [x29, #%d]", i, g.offsetOf(p.Name))
		}
	}
	g.genStmt(f.Body)
	g.emit("\tmov\tx0, #0")
	g.emit("%s:", g.retLabel)
	g.emit("\tmov\tsp, x29")
	g.emit("\tldp\tx29, x30, [sp], #16")
	g.emit("\tret")
}

func GenProgram(prog *Program) (out string, err error) {
	defer func() {
		if r := recover(); r != nil {
			if ce, ok := r.(*CodegenError); ok {
				err = ce
				return
			}
			panic(r)
		}
	}()
	g := &codegen{}
	for _, f := range prog.Funcs {
		g.genFun(f)
		g.buf.WriteByte('\n')
	}
	return g.buf.String(), nil
}

/** end hidden */

/** begin skeleton */
import "fmt"

func GenProgram(prog *Program) (string, error) {
	_ = prog
	return "", fmt.Errorf("GenProgram is not implemented yet")
}

/** end skeleton */
