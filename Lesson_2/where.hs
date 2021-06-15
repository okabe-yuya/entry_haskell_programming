doublePlusTwo x = doubleX + 2
  where doubleX = x * 2

inc n = n + 1
double n = n * 2
square n = n ** 2

q3 n = if cond
      then n - 2
      else 3 * n + 1
  where cond = even n
  