addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe Nothing _ = Nothing
addMaybe _ Nothing = Nothing
addMaybe (Just v1) (Just v2) = Just (v1 + v2)

maybeInc = (+) <$> Just 1

data User = User {
  name :: String,
  gameId :: Int,
  score :: Int
} deriving Show

serverUserName :: Maybe String
serverUserName = Just "Sue"

serverGameId :: Maybe Int
serverGameId = Just 1337

serverScore :: Maybe Int
serverScore = Just 700
