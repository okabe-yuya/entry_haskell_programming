halve :: Int -> Int -> Int 
halve a b = div a b

printDouble :: Int -> String 
printDouble n = show (n * 2)

-- MEMO: headでは空のリストを返すことが出来ない
-- 現状だと戻り値の方を統一する必要があるため
-- emptyHead :: [a] -> [b]
-- emptyHead [] = []
-- emptyHead (x:_) = x