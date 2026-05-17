#!/bin/bash
for l in go jl ml rs; do
    (cd ${l} && bash test_readxml.sh)
done
