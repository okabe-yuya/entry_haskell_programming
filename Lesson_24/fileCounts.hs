{-# LANGUAGE OverloadedStrings #-}
import System.IO
import System.Environment
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

type Counts = (Int, Int, Int)

debug :: T.Text
debug = (countsText . getCounts) "this is\n some text"

getCounts :: T.Text -> Counts
getCounts input = (charCount, wordCount, lineCount)
  where charCount = T.length input
        wordCount = (length . T.words) input
        lineCount = (length . T.lines) input

countsText :: Counts -> T.Text
countsText (cc, wc, lc) = T.pack (unwords [ "chars: ", show cc, " words: ", show wc, " lines: ", show lc ])


-- 遅延I/O ver
-- main :: IO ()
-- main = do
--   args <- getArgs
--   let fileName = head args
--   input <- readFile fileName
--   let summary = (countsText . getCounts) input
--   appendFile "./Lesson_24/stats.dat" (mconcat [fileName, " ", summary, "\n"])

--   putStrLn summary

-- 非遅延I/Over
main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  input <- TIO.readFile fileName
  let summary = (countsText . getCounts) input
  TIO.appendFile "./Lesson_24/stats.dat" (mconcat [T.pack fileName, " ", summary, "\n"])

  TIO.putStrLn summary