package main

import "github.com/subchen/go-xmldom"

func readxml(filename string) *xmldom.Document {
    dom, err := xmldom.ParseFile(filename)
    if err != nil {
        panic(err)
    }
    return dom
}
