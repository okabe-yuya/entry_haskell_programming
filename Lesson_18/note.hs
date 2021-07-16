import qualified Data.Map as Map

data Box a = Box a deriving Show

wrap :: a -> Box a
wrap x = Box x

unwrap :: Box a -> a
unwrap (Box x) = x

boxMap :: (a -> b) -> [Box a] -> [Box b]
boxMap f boxes = map f boxes


data Triple a = Triple a a a deriving Show
type Point3D = Triple Double
aPoint :: Point3D
aPoint = Triple 0.1 53.2 12.3

type FullName = Triple String
aName :: FullName
aName = Triple "Howard" "Phillips" "Lovecraft"

first :: Triple a -> a
first (Triple fst _ _) = fst

second :: Triple a -> a
second (Triple _ second _) = second

third :: Triple a -> a
third (Triple _ _ third) = third

toList :: Triple a -> [a]
toList (Triple fst second third) = [fst, second, third]

transform :: (a -> a) -> Triple a -> Triple a
transform f (Triple x y z) = Triple (f x) (f y) (f z)

tripleMap :: (a -> b) -> [Triple a] -> [Triple b]
tripleMap f triples = map f triples

-- リストの独自定義
data List a = Empty | Cons a (List a) deriving Show

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq)
organs :: [Organ]
organs = [Heart,Heart,Brain,Spleen,Spleen,Kidney]

ids:: [Int]
ids = [2,7,13,14,21,24]

pairs :: [(Int, Organ)]
pairs = [(2, Heart), (7, Heart), (13, Brain), (14, Spleen), (21, Spleen), (24, Kidney)]

organPairs :: [(Int, Organ)]
organPairs = zip ids organs

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList organPairs