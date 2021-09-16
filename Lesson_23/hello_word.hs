{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

helloPerson :: T.Text -> T.Text
helloPerson name = mconcat ["Hello ", name, "!"]


copyInt :: Int -> [Int]
copyInt n = [n, n]

applyMonad :: [Int]
applyMonad = [1, 2, 3] >>= copyInt

test :: [Int]
test = do
  v <- [1, 2, 3]
  copyInt v

main = do
  putStrLn "Hello! What's your name?"
  name <- getLine
  let statement = helloPerson (T.pack name)
  TIO.putStrLn statement

