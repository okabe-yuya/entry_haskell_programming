intlist :: [Int]
intlist = [1,2,3,4,5]

doubler :: Int -> Int
doubler n = n * 2

doublerList :: [Int] -> [Int]
doublerList list = do
  val <- list
  let applied = doubler val
  return applied
