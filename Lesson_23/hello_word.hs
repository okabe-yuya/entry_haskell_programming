{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

helloPerson :: T.Text -> T.Text 
helloPerson name = mconcat ["Hello ", name, "!"]

main = do
  putStrLn "Hello! What's your name?"
  name <- getLine
  let statement = helloPerson (T.pack name)
  TIO.putStrLn statement

