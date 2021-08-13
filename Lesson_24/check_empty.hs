import System.IO

main :: IO ()
main = do
  myFile <- openFile "./Lesson_24/hello.txt" ReadMode
  firstLine <- hGetLine myFile
  putStrLn firstLine
  secondLine <- hIsEOF myFile
  validSecondLine <- if not secondLine
                      then hGetLine myFile
                      else return "empty"
  putStrLn validSecondLine
  putStrLn "done!!!!"