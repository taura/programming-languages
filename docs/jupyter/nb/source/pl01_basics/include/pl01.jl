### if label == "A function"
function f(x)
    x + 1
end
### endif
### if label == "Apply a function"
f(3)
### endif
### if label == "A recursive function"
function fib(n :: Int)
    if n < 2
        1
    else
        fib(n - 1) + fib(n - 2)
    end
end
### endif
### if label == "A variable"
function fib2(n :: Int)
  if n < 2
      1
  else
      x = fib2(n - 1)
      y = fib2(n - 2)
      x + y
  end
end
### endif
### if label == "A data type"
struct Person
    name :: String
    date_of_birth :: String
end
### endif
### if label == "Person name"
function person_name(p :: Person)
    p.name
end

person_name(Person("Masakazu Mimura", "1967/6/8"))
### endif
### if label == "bintree"
struct Bintree
    left :: Union{Nothing,Bintree}
    right :: Union{Nothing,Bintree}
end
### endif
### if label == "mk_tree"
function mk_tree(n :: Int)
    if n == 0
        nothing
    else
        rc = div(n - 1, 2)
        lc = n - 1 - rc
        Bintree(mk_tree(lc), mk_tree(rc))
    end
end
### endif
### if label == "count_nodes"
count_nodes(t :: Nothing) = 0
count_nodes(t :: Bintree) = 1 + count_nodes(t.left) + count_nodes(t.right)
### endif
### if label == "1000 nodes"
count_nodes(mk_tree(1000))
### endif
