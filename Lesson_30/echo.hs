-- getLine :: IO String
-- putStrLn :: String -> IO ()
-- echo :: IO ()

-- IO String -> (String -> IO ()) -> IO ()
-- Applicative f => f a(IO String) -> (a(String) -> f b) -> f b

-- ↑↑↑　f = IO
-- a = String

echo :: IO ()
echo = getLine  >>= putStrLn

readInt :: IO Int
readInt = read <$> getLine

printDouble :: Int -> IO ()
printDouble n = print (n * 2)

main :: IO ()
main = do
  readInt >>= printDouble