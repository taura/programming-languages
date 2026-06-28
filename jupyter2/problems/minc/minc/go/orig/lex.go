package main

import (
	"fmt"
	"strconv"
)

type TokKind int

const (
	TNum TokKind = iota
	TId
	TLong
	TReturn
	TIf
	TElse
	TBreak
	TContinue
	TLParen
	TRParen
	TLBrace
	TRBrace
	TComma
	TSemi
	TAssign
	TEq
	TNe
	TLt
	TGt
	TLe
	TGe
	TPlus
	TMinus
	TStar
	TSlash
	TPercent
	TNot
	TTilde
	TEOF
)

type Token struct {
	Kind TokKind
	Num  int64
	Str  string
}

func (t Token) String() string {
	switch t.Kind {
	case TNum:
		return fmt.Sprintf("NUM(%d)", t.Num)
	case TId:
		return fmt.Sprintf("ID(%s)", t.Str)
	}
	names := map[TokKind]string{
		TLong: "long", TReturn: "return", TIf: "if", TElse: "else",
		TBreak: "break", TContinue: "continue",
		TLParen: "(", TRParen: ")", TLBrace: "{", TRBrace: "}",
		TComma: ",", TSemi: ";", TAssign: "=", TEq: "==", TNe: "!=",
		TLt: "<", TGt: ">", TLe: "<=", TGe: ">=", TPlus: "+", TMinus: "-",
		TStar: "*", TSlash: "/", TPercent: "%", TNot: "!", TTilde: "~",
		TEOF: "<eof>",
	}
	return names[t.Kind]
}

type LexError struct{ Msg string }

func (e *LexError) Error() string { return "lex error: " + e.Msg }

var keywords = map[string]TokKind{
	"long": TLong, "return": TReturn, "if": TIf, "else": TElse,
	"break": TBreak, "continue": TContinue,
}

func isDigit(c byte) bool { return c >= '0' && c <= '9' }
func isAlpha(c byte) bool {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_'
}
func isAlnum(c byte) bool { return isAlpha(c) || isDigit(c) }
func isSpace(c byte) bool { return c == ' ' || c == '\t' || c == '\n' || c == '\r' }

func Tokenize(s string) ([]Token, error) {
	n := len(s)
	var toks []Token
	i := 0
	peek := func(k int) byte {
		if i+k < n {
			return s[i+k]
		}
		return 0
	}
	for i < n {
		c := s[i]
		switch {
		case isSpace(c):
			i++
		case c == '/' && peek(1) == '/':
			for i < n && s[i] != '\n' {
				i++
			}
		case c == '/' && peek(1) == '*':
			i += 2
			for i < n && !(s[i] == '*' && peek(1) == '/') {
				i++
			}
			if i >= n {
				return nil, &LexError{"unterminated block comment"}
			}
			i += 2
		case isDigit(c):
			start := i
			for i < n && isDigit(s[i]) {
				i++
			}
			v, _ := strconv.ParseInt(s[start:i], 10, 64)
			toks = append(toks, Token{Kind: TNum, Num: v})
		case isAlpha(c):
			start := i
			for i < n && isAlnum(s[i]) {
				i++
			}
			word := s[start:i]
			if kw, ok := keywords[word]; ok {
				toks = append(toks, Token{Kind: kw})
			} else {
				toks = append(toks, Token{Kind: TId, Str: word})
			}
		default:
			two := func(k TokKind) {
				toks = append(toks, Token{Kind: k})
				i += 2
			}
			one := func(k TokKind) {
				toks = append(toks, Token{Kind: k})
				i++
			}
			switch {
			case c == '=' && peek(1) == '=':
				two(TEq)
			case c == '!' && peek(1) == '=':
				two(TNe)
			case c == '<' && peek(1) == '=':
				two(TLe)
			case c == '>' && peek(1) == '=':
				two(TGe)
			default:
				switch c {
				case '(':
					one(TLParen)
				case ')':
					one(TRParen)
				case '{':
					one(TLBrace)
				case '}':
					one(TRBrace)
				case ',':
					one(TComma)
				case ';':
					one(TSemi)
				case '=':
					one(TAssign)
				case '<':
					one(TLt)
				case '>':
					one(TGt)
				case '+':
					one(TPlus)
				case '-':
					one(TMinus)
				case '*':
					one(TStar)
				case '/':
					one(TSlash)
				case '%':
					one(TPercent)
				case '!':
					one(TNot)
				case '~':
					one(TTilde)
				default:
					return nil, &LexError{fmt.Sprintf("unexpected character %q at offset %d", c, i)}
				}
			}
		}
	}
	toks = append(toks, Token{Kind: TEOF})
	return toks, nil
}
