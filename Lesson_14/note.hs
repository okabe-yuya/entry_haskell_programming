-- -- data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Show)
-- data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6
-- data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Eq, Ord)
data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Enum)

-- 独自の振る舞いを定義することが出来る
instance Show SixSideDie where
  show S1 = "Ⅰ"
  show S2 = "Ⅱ"
  show S3 = "Ⅲ"
  show S4 = "Ⅳ"
  show S5 = "Ⅴ"
  show S6 = "Ⅵ"

instance Eq SixSideDie where
  (==) S6 S6 = True
  (==) S5 S5 = True
  (==) S4 S4 = True
  (==) S3 S3 = True
  (==) S2 S2 = True
  (==) S1 S1 = True
  (==) _ _ = False

-- Q1
data SampleNumber = One | Two | Three deriving Enum
instance Eq SampleNumber where
  (==) num1 num2 = fromEnum num1 == fromEnum num2
instance Ord SampleNumber where
  compare num1 num2 = compare (fromEnum num1) (fromEnum  num2)

-- Q2
data FiveSideDie = Side1 | Side2 | Side3 | Side4 | Side5 deriving (Show, Eq, Enum)
class (Enum a, Eq a) => Die a where
  roll :: Int -> a

instance Die FiveSideDie where
  roll n = toEnum (n `mod` 5)

