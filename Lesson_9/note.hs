import Data.Char

remove _ [] = []
remove f (x:xs) = if f x
                  then remove f xs
                  else [x] ++ remove f xs

myProduct [] = 0
myProduct lst = foldl (*) 1 lst

myFoldl _ init [] = init
myFoldl f init (x:xs) = myFoldl f next xs
  where next = f init x

myFoldr _ init [] = init
myFoldr f init (x:xs) = f next x
  where next = myFoldr f init xs

myElem _ [] = False
myElem x lst = length filterd == 1
  where filterd = filter (\n -> n == x) lst 

isPalindrome text = toLowered == reverse toLowered
  where removeSpace = filter (/=' ') text
        toLowered = map toLower removeSpace

harmonic n = sum (take seriesValues)
  where seriesPairs = zip (cycle [1.0]) [1.0, 2.0 ..]
        seriesValues = map (\pair -> (fst pair) / (snd pair)) seriesValues