### if label == "A procedural recurrence"
def a(n):
    x = 1.0
    for i in range(n):
        x = 0.9 * x + 2.0
    return x
### endif
### if label == "A simple recurrence"
def a(n):
    if n == 0:
        return 1.0
    else:
        return 0.9 * a(n - 1) + 2.0
### endif
### if label == "Subset sum"
def subset_sum(a, v):
    if v == 0:
        return [0] * len(a)
    if v < 0 or len(a) == 0:
        return None
    k1 = subset_sum(a[1:], v - a[0])
    if k1 is not None:
        return [1] + k1
    k0 = subset_sum(a[1:], v)
    if k0 is not None:
        return [0] + k0
    return None
### endif
### if label == "Subset sum test"
import random
def make_subset_sum(seed, ans):
    rg = random.Random()
    rg.seed(seed)
    n = rg.randrange(10, 20)
    a = [rg.randrange(10, 60) for i in range(n)]
    if ans:
        shuffled = a[:]
        rg.shuffle(shuffled)
        m = rg.randrange(5, n // 2)
        v = sum(shuffled[:m])
        chk = subset_sum(a, v)
        assert(chk is not None), (a, v)
        return a, v
    else:
        for i in range(100):
            s = sum(a)
            v = rg.randrange(s//3, s)
            # print(a, v)
            chk = subset_sum(a, v)
            if chk is None:
                return a, v
            else:
                # print(chk)
                pass
        assert(0), (seed, ans)

def make_problems(n):        
    for i in range(n):
        a, v = make_subset_sum(20000 + i, i < n / 2)
        print(a, v, subset_sum(a, v))

make_problems(4)        
# subset_sum([1,2,3,4,5], 8)
### endif
