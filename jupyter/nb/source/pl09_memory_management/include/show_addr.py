#!/usr/bin/env python
import re
import matplotlib.pyplot as plt

def show_addr(fp, lang):
    p = re.compile(r"^(?P<i>\d+)\s+(?P<a>\d+)$")
    X = []
    Y = []
    for line in fp:
        m = p.match(line)
        assert(m), line
        i = int(m.group("i"))
        a = int(m.group("a"))
        X.append(i)
        Y.append(a)
    min_y = min(Y)
    Y = [y - min_y for y in Y]
    n = len(set(Y))
    cut = len(Y) // 4
    print(f"{n} distinct addresses")
    plt.scatter(X[cut:], Y[cut:], label=lang)

def main():
    plt.figure()
    for lang in ["cc", "go", "jl", "ml", "rs"]:
        fp = open(f"out/p3/{lang}/show_addr/out.csv")
        show_addr(fp, lang)
        fp.close()
    plt.title("addresses")
    plt.legend()
    plt.show()

main()

        
    
