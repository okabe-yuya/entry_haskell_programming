-- Show -> デバッグのため
-- Enum -> 数値変換、文字列変換が楽になるため
-- Bounded -> 回転時の最大数と最小数を定義するため
data FourLetterAlphabet = L1 | L2 | L3 | L4 deriving (Show, Enum, Bounded)
data ThreeLetterAlphabet = Alpha | Beta | Kappa deriving (Show, Enum, Bounded)

rotN :: (Bounded a, Enum a) => Int -> a -> a
rotN alphabetSize c = toEnum rotation
  where halfAlphabet = alphabetSize `div` 2
        offset = fromEnum c + halfAlphabet
        rotation = offset `mod` alphabetSize

rotNdecoder :: (Bounded a, Enum a) => Int -> a -> a
rotNdecoder n c = toEnum rotation
  where halfN = n `div` 2
        offset = if even n
                 then fromEnum c + halfN
                 else 1 + fromEnum c + halfN
        rotation = offset `mod` n

rotEncoder :: String -> String
rotEncoder text = map rotChar text
  where alphaSize = 1 + fromEnum (maxBound :: Char)
        rotChar = rotN alphaSize

rotDecoder :: String -> String
rotDecoder text = map rotCharDecoder text
  where alphaSize = 1 + fromEnum (maxBound :: Char)
        rotCharDecoder = rotNdecoder alphaSize

-- threeLetter functions
threeLetterEncoder :: [ThreeLetterAlphabet] -> [ThreeLetterAlphabet]
threeLetterEncoder vals = map rot3l vals
  where alphaSize = 1 + fromEnum (maxBound :: ThreeLetterAlphabet)
        rot3l = rotN alphaSize

threeLetterDecoder :: [ThreeLetterAlphabet] -> [ThreeLetterAlphabet]
threeLetterDecoder vals = map rot3decoder vals
  where alphaSize = 1 + fromEnum (maxBound :: ThreeLetterAlphabet)
        rot3decoder = rotNdecoder alphaSize

fourLetterEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
fourLetterEncoder vals = map rot4l vals
  where alphaSize = 1 + fromEnum (maxBound :: FourLetterAlphabet)
        rot4l = rotN alphaSize

fourLetterDecoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
fourLetterDecoder vals = map rot4decoder vals
  where alphaSize = 1 + fromEnum (maxBound :: FourLetterAlphabet)
        rot4decoder = rotNdecoder alphaSize

-- XOR
xorBool :: Bool -> Bool -> Bool
xorBool value1 value2 = (value1 || value2) && not (value1 && value2)

xorPair :: (Bool, Bool) -> Bool
xorPair (v1, v2) = xorBool v1 v2

-- zip [1,2,3] [4,5,6] -> [(1,4),(2,5),(3,6)]
xor :: [Bool] -> [Bool] -> [Bool]
xor lst1 lst2 = map xorPair (zip lst1 lst2)

type Bits = [Bool]

maxBits :: Int
maxBits = length (intToBits' maxBound)

intToBits :: Int -> Bits
intToBits n = leadingFalses ++ reversedBits
  where reversedBits = reverse (intToBits' n)
        missingBits = maxBits - (length reversedBits)
        leadingFalses = take missingBits (cycle [False])

intToBits' :: Int -> Bits
intToBits' 0 = [False]
intToBits' 1 = [True]
intToBits' n = if remainder == 0
               then False : intToBits' nextVal
               else True : intToBits' nextVal
  where remainder = n `mod` 2
        nextVal = n `div` 2

charToBits :: Char -> Bits
charToBits char = intToBits (fromEnum char)

bitsToInt :: Bits -> Int
bitsToInt bits = sum (map (\x -> 2^(snd x)) trueLocations)
  where size = length bits
        indices = [size-1, size-2 .. 0]
        trueLocations = filter (\x -> fst x == True) (zip bits indices)

bitsToChar :: Bits -> Char
bitsToChar bits = toEnum (bitsToInt bits)