import System.IO
import qualified Data.Text.IO as TIO
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  let saveFileName = last args
  input <- TIO.readFile fileName
  TIO.writeFile saveFileName input

  putStrLn "done!!!"
