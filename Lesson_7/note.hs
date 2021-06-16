myGCD a b = if remainder == 0
            then b
            else myGCD b remainder
  where remainder = a `mod` b

myGCD2 b 0 = b
myGCD2 a b = myGCD2 b remainder
  where remainder = a `mod` b

-- pattern mattching
sayAmount 1 = "one"
sayAmount 2 = "two"
sayAmount n = "a bunch"

myTail (_:xs) = xs
myTail [] = error "No tail for empty list"