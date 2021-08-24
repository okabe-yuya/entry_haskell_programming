data Box a = Box a deriving Show

instance Functor Box where
  fmap func (Box a) = Box (func a)

generateList :: Int -> a -> [a]
generateList n val = take n (repeat val)

morePresents :: Box a -> Int -> Box [a]
morePresents box n = f <$> box
  where f = generateList n

myBox :: Box Int
myBox = Box 1

nest :: a -> Box a
nest val = Box val

nestBox :: Box a -> Box (Box a)
nestBox box = fmap nest box

unnest :: Box a -> a
unnest (Box val) = val

unwrap :: Box (Box a) -> Box a
unwrap nestBox = fmap unnest nestBox
