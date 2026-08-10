#!/usr/bin/env python
import re
import matplotlib.pyplot as plt

def show_dt(fp, lang):
    p = re.compile(r"^(?P<i>\d+)\s+(?P<a>\d+)\s+(?P<dt>\d+)$")
    D = []
    for line in fp:
        m = p.match(line)
        assert(m), line
        i = int(m.group("i"))
        a = int(m.group("a"))
        dt = int(m.group("dt"))
        D.append((i, a, dt))
    plt.scatter([x for x,_,_ in D], [dt for _,_,dt in D], label=lang)

def main():
    plt.figure()
    for lang in ["cc", "go", "jl", "ml", "rs"]:
        fp = open(f"out/p4/{lang}/measure_time/out.csv")
        show_dt(fp, lang)
        fp.close()
    plt.title("allocation time")
    plt.legend()
    plt.show()

main()

        
    
