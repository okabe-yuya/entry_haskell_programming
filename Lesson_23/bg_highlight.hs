{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

dharma :: T.Text 
dharma = "धर्म"

bgText :: T.Text 
bgText = "श्रेयान्स्वधर्मो विगुणः परधर्मात्स्वनुष्ठितात्।स्वधर्मे निधनं श्रेयः परधर्मो भयावहः"

highlight :: T.Text -> T.Text -> T.Text 
highlight query fullText = T.intercalate highlighted pieces -- "This{\n}is{\n}it"
  where pieces = T.splitOn query fullText -- "This\nis\nit" -> "\n" -> ["This","is","it"]
        highlighted = mconcat ["{", query, "}"] -- "{\n}"

-- Effect
main = do
  TIO.putStrLn (highlight dharma bgText)
