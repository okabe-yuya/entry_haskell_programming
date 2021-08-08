-- import Control.Monad

-- main :: IO ()
-- main = do
--   inputs <- replicateM 3 getLine 
--   let joined = mconcat inputs
--   putStrLn joined
 

calc :: [String] -> Int
calc (val1:"+":val2:_) = read val1 + read val2
calc (val1:"*":val2:_) = read val1 * read val2
calc _ = 0

main :: IO ()
main = do
  userInput <- getContents
  let values = lines userInput
  print (calc values)