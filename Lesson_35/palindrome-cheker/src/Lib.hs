{-# LANGUAGE OverloadedStrings #-}
module Lib ( isPalindrome ) where

import qualified Data.Text as T
import Data.Char (toLower, isSpace, isPunctuation)
import GHC.Unicode (isSpace)
import qualified Data.Char as T

stripWithSpace :: T.Text -> T.Text
stripWithSpace = T.filter (not . isSpace)

stripPunctuation :: T.Text -> T.Text
stripPunctuation = T.filter (not . isPunctuation)

preProcess :: T.Text -> T.Text
preProcess = stripWithSpace . stripPunctuation . T.toLower

isPalindrome :: T.Text -> Bool
isPalindrome text = cleanText == T.reverse cleanText
  where cleanText = preProcess text
