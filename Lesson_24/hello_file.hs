import System.IO

main :: IO ()
main = do
  helloFile <- openFile "./Lesson_24/hello.txt" ReadMode
  firstLine <- hGetLine helloFile
  putStrLn firstLine

  secondLine <- hGetLine helloFile
  goodbyeFile <- openFile "./Lesson_24/goodbye.txt" WriteMode
  hPutStrLn goodbyeFile secondLine

  hClose helloFile
  hClose goodbyeFile
  putStrLn "done!!!!"
