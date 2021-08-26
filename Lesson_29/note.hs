maybeConcat :: Maybe String -> Maybe String -> Maybe String
maybeConcat s1 s2 = (++) <$> s1 <*> s2

examleMaybeConcat :: Maybe String
examleMaybeConcat = maybeConcat (Just "hello ")  (Just " world!")

doorPrize :: [Int]
doorPrize = [1000, 2000, 3000]

boxPrize :: [Int]
boxPrize = [500, 20000]

-- 決定論的なコンテキスト
-- totalPrize :: Int
-- totalPrize = (+) doorPrize boxPrize

-- 非決定論的なコンテキスト
totalPrize :: [Int]
totalPrize = pure (+) <*> doorPrize <*> boxPrize

totalMagn :: [Int]
totalMagn = pure (*) <*> doorPrize <*> [10, 50]


allFmap :: Applicative f => (a -> b) -> f a -> f b
allFmap func a = pure func <*> a

example :: Int
example = (*) ((+) 2 4) 6

-- なぜMaybeとして解釈されるのか謎
exampleMaybe :: Maybe Int
exampleMaybe = pure (*) <*> (pure (+) <*> pure (2) <*> pure(4)) <*> pure 6

beerPack :: [Int]
beerPack = [6, 12]

yesterday :: [Int]
yesterday = [2, 2]

comming :: [Int]
comming = [2, 3]

drinkAmount :: [3, 4]