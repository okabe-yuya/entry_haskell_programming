import System.Environment
import Control.Monad

main :: IO ()
main = do
  putStrLn "please input numbers"
  args <- getArgs
  let linesToRead = if length args > 0
                    then read (head args)
                    else 0 :: Int
  numbers <- replicateM linesToRead getLine
  let ints = map read numbers :: [Int]
  print ("total: " ++ show (sum ints))

-- quickCheck1
-- mainQ1 :: IO ()
-- mainQ1 = do
--   putStrLn "please input numbers"
--   mapM_ (\_ -> getLine) [1,2,3]
