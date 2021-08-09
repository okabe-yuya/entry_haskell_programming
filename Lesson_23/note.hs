{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T

firstWord :: String 
firstWord = "pessimsim"

secondWord :: T.Text 
secondWord = T.pack firstWord

thirdWord :: String 
thirdWord = T.unpack secondWord

fourthWord :: T.Text
fourthWord = T.pack thirdWord

myWord :: T.Text 
myWord = "dog"

myLines :: T.Text -> [T.Text]
myLines text = T.splitOn "\n" text

myLinesSample :: [T.Text]
myLinesSample = myLines words
  where words = "This\nIs\nIt" :: T.Text

breakText :: T.Text 
breakText = "\n"

exampleText :: T.Text 
exampleText = "this\nis\ninput"