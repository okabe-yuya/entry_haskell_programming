import GHC.RTS.Flags (DebugFlags(apply))
minOfThree :: (Ord a) => a -> a -> a -> a
minOfThree v1 v2 v3 = min v1 (min v2 v3)

readInt :: IO Int
readInt = read <$> getLine

minOfInts :: IO Int
minOfInts = minOfThree <$> readInt <*> readInt <*> readInt

minOfMaybeInts :: Maybe Int
minOfMaybeInts = minOfThree <$> m1 <*> m2 <*> m3
  where m1 = Just 10
        m2 = Just 3
        m3 = Just 6

add10 :: Int -> Int
add10 n = n + 10

applyAdd10 :: [Int]
applyAdd10 = fmap add10 [1 .. 10]

addN :: Int -> Int -> Int
addN n m = n + m

applyAddN :: [Int]
applyAddN = fmap addN [1 .. 10] <*> 10

main :: IO ()
main = do
  putStrLn "Enter three numbers"
  minInt <- minOfInts
  putStrLn (show minInt ++ " is the smallest")

