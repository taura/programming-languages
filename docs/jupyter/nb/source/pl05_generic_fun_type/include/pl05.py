import random
class random_float_generator:
    def __init__(self, a, b, n):
        self.rg = random.Random()
        self.i = 0
        self.n = n
        self.a = a
        self.b = b
    def next(self):
        if self.i < self.n:
            x = self.a + (self.b - self.a) * self.rg.random()
            self.i += 1
            return x
        else:
            return None

rfg = random_float_generator(2, 3, 10)
while 1:
    f = rfg.next()
    if f is None: break
    print(f)
