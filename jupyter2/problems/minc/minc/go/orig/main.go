package main

import (
	"fmt"
	"io"
	"os"
)

func readInput() (string, error) {
	if len(os.Args) > 1 {
		b, err := os.ReadFile(os.Args[1])
		return string(b), err
	}
	b, err := io.ReadAll(os.Stdin)
	return string(b), err
}

func writeOutput(asm string) error {
	if len(os.Args) > 2 {
		return os.WriteFile(os.Args[2], []byte(asm), 0644)
	}
	_, err := io.WriteString(os.Stdout, asm)
	return err
}

func fatal(err error) {
	fmt.Fprintln(os.Stderr, err)
	os.Exit(1)
}

func main() {
	src, err := readInput()
	if err != nil {
		fatal(err)
	}
	prog, err := ParseString(src)
	if err != nil {
		fatal(err)
	}
	asm, err := GenProgram(prog)
	if err != nil {
		fatal(err)
	}
	if err := writeOutput(asm); err != nil {
		fatal(err)
	}
}
