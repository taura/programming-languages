
function collatz(n :: Int64)
  if n % 2 == 0
      div(n, 2)
  else
      3 * n + 1
  end
end
