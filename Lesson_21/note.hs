import qualified Data.Map as Map

helloPerson :: String -> String
helloPerson name = "Hello" ++ " " ++ name ++ "!"

-- Monad IO
-- main :: IO ()
-- main = do
--   putStrLn "Hello! What's your name?"
--   name <- getLine
--   let statement = helloPerson name
--   putStrLn statement

nameData :: Map.Map Int String
nameData = Map.fromList [(1, "yamada"), (2, "tanaka"), (3, "satou")]

-- Monad Maybe
maybeMain :: Maybe String 
maybeMain = do
  name <- Map.lookup 1 nameData
  let statement = helloPerson name
  return statement
