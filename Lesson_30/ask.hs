askForName :: IO ()
askForName = putStrLn "What is your name?"

nameStatement :: String -> String
nameStatement name = "Hello, " ++ name ++ "!"

main :: IO ()
main = do
  (askForName >> getLine) >>= (\name -> return (nameStatement name)) >>= putStrLn