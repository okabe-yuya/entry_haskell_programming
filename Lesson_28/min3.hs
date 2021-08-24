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

main :: IO ()
main = do
  putStrLn "Enter three numbers"
  minInt <- minOfInts
  putStrLn (show minInt ++ " is the smallest")

