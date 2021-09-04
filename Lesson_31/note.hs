helloPerson :: String -> String
helloPerson name = mconcat ["Hello ", name, "!"]

-- main :: IO ()
-- main = do
--   name <- getLine
--   let statement = helloPerson name
--   putStrLn statement

main :: IO ()
main = do
  -- getLine >>= (\name -> (\statement -> putStrLn statement) (helloPerson name))
  getLine >>= (\name -> return (helloPerson name)) >>= (\statement -> putStrLn statement)



