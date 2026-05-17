package main
import (
	"github.com/subchen/go-xmldom"
)

func parse(filename string) *xmldom.Document {
	node := xmldom.Must(xmldom.ParseFile(filename))
	return node
}

func height(node *xmldom.Node) int {
	if node == nil {
		return 0
	} else {
		max := 0
		for _, child := range node.Children {
			d := height(child)
			if d > max {
				max = d
			}
		}
		return max + 1
	}
}

