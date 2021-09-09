{-# LANGUAGE OverloadedStrings #-}
import Control.Monad
import qualified Data.Text as T

powersOfTwo :: Int -> [Int]
powersOfTwo n = do
  value <- [ 1..n ]
  return (2 ^ value)

powersOfTwoMap :: Int -> [Int]
powersOfTwoMap n = map (\n -> 2 ^ n) [ 1..10 ]

powersOfTwoAndThree :: Int -> [(Int, Int)]
powersOfTwoAndThree n = do
  value <- [1 .. n]
  let powerOfTwo = 2 ^ value
  let powerOfThree = 3 ^ value
  return (powerOfTwo, powerOfThree)

allEvenOdds :: Int -> [(Int, Int)]
allEvenOdds n = do
  evenValue <- [2, 4 .. n]
  oddValue <- [1, 3 .. n]
  return (evenValue, oddValue)

quick1 :: [(Int, Int)]
quick1 = do
  value <- [1 .. 10]
  return (value, value ^ 2)

evensGuard :: Int -> [Int]
evensGuard n = do
  value <- [1 .. n]
  guard(even value)
  return value

filterGuard :: (a -> Bool) -> [a] -> [a]
filterGuard func lst = do
  value <- lst
  guard(func value)
  return value

powersOfTwo2 :: Int -> [Int]
powersOfTwo2 n = [2 ^ value | value <- [1 .. n]]

powersOfTwoAndThree2 :: Int -> [(Int, Int)]
powersOfTwoAndThree2 n = [(powersOfTwo, powersOfThree) | value <- [1 .. n], let powersOfTwo = 2 ^ value, let powersOfThree = 3 ^ value]

allEvenOdds2 :: Int -> [(Int, Int)]
allEvenOdds2 n = [(evenValue, oddValue) | evenValue <- [2,4 .. n], oddValue <- [1,3 .. n]]

colors :: [T.Text]
colors = ["brown", "blue", "pink", "orange"]

toMr :: [T.Text]
toMr = [mconcat["Mr.", uppered] | color <- colors, let uppered = T.toUpper color]