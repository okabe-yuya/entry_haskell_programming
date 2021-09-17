{-# LANGUAGE OverloadedStrings #-}

module Palindrome(
  isPalindrome,
  preprocess,
) where

import qualified Data.Text as T
import Data.Char (toLower, isSpace, isPunctuation)


stripWhiteSpace :: T.Text -> T.Text
stripWhiteSpace = T.replace " " ""

stripPunctuation :: T.Text -> T.Text
stripPunctuation = T.filter (not . isPunctuation)

toLowerCase :: T.Text -> T.Text
toLowerCase = T.map toLower

preprocess :: T.Text -> T.Text
preprocess = stripWhiteSpace . stripPunctuation . toLowerCase

isPalindrome :: T.Text -> Bool
isPalindrome text = cleanText == T.reverse cleanText
  where cleanText = preprocess text
