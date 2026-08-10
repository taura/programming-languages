#!/usr/bin/env python
import re
import matplotlib.pyplot as plt

def cum_dist(fp, lang):
    p = re.compile(r"^(?P<i>\d+)\s+(?P<a>\d+)\s+(?P<dt>\d+)$")
    D = []
    for line in fp:
        m = p.match(line)
        assert(m), line
        i = int(m.group("i"))
        a = int(m.group("a"))
        dt = int(m.group("dt"))
        D.append((i, a, dt))
    D.sort(key=(lambda d: d[2]))
    n = len(D)
    h = 100
    X = [ (i + 1) / n for i in range(n) ]
    Y = [ dt for _,_,dt in D ]
    plt.plot(X[-h:], Y[-h:], label=lang)

def main():
    plt.figure()
    for lang in ["cc", "go", "jl", "ml", "rs"]:
        fp = open(f"out/p4/{lang}/measure_time/out.csv")
        cum_dist(fp, lang)
        fp.close()
    plt.title("cumulative distribution of allocation time")
    plt.legend()
    plt.show()

main()

        
    
