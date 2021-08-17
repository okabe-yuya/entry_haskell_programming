import System.Environment
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import Distribution.Utils.Generic (safeInit)

intToChar :: Int -> Char
intToChar int = toEnum safeInt
  where safeInt = int `mod` 255

intToBC :: Int -> BC.ByteString
intToBC int = BC.pack [intToChar int]

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName
  glitched <- return imageFile
  let glitchedFileName = mconcat ["Lesson_25", "/gliched_image.jpg"]
  BC.writeFile glitchedFileName glitched
  print "all done !"
