-- data AuthorName = AuthorName String String
-- data Book = Book AuthorName String String Int Double 
data AuthorName = AuthorName {
  firstName :: String,
  lastName :: String
}

data Book = Book {
  author :: AuthorName,
  isbn :: String,
  title :: String,
  year :: Int,
  price :: Double
}

-- 私が書いたやつ。色々と違ったみたい
-- data Shape = CircleShape Circle | SquareShape Square | RectangleShape Rectangle
-- data Circle = Circle {
--   radius :: Int,
--   π :: Double
-- }
-- data Square = Square {
--   sWidth :: Int,
--   sHeight :: Int
-- }
-- data Rectangle = Rectangle {
--   rWidth :: Int,
--   rHeight :: Int
-- }

-- calcEria :: Shape -> Double
-- calcEria (Circle radius π) = π * radius ^ 2
-- calcEria (Square sWidth sHeight) = sWidth * sHeight
-- calcEria (Rectangle sWidth sHeight) = sWidth * sHeight

type Radius = Double
type Height = Double
type Widht = Double

data Shape = Circle Radius | Square Height | Rectangle Height Widht deriving Show
area (Circle r) = pi * r ^ 2
area (Square h) = h ^ 2
area (Rectangle h w) = h * w
