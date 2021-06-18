myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myTake _ [] = []
myTake 0 _ = []
myTake n (x:xs) = x : myTake (n - 1) xs

myCycle (x:xs) = x:myCycle (x:xs)

ackermann 0 n = n + 1
ackermann m 0 = ackermann (m - 1) 1
ackermann m n = ackermann (m - 1) (ackermann m (n - 1))

myReverse [] = []
myReverse (x:xs) = (myReverse xs) ++ [x]

fib 0 = 0
fib 1 = 1
fib n = fib (n -1) + fib (n - 2)
