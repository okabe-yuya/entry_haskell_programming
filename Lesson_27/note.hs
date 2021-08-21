successfulRequest :: Maybe Int
successfulRequest = Just 6

failedRequest :: Maybe Int
failedRequest = Nothing

incMaybe :: Maybe Int -> Maybe Int
incMaybe (Just n) = Just (n + 1)
incMaybe Nothing  = Nothing

sampleString :: Maybe String
sampleString = Just "hello world"

reverseMaybe :: Maybe String -> Maybe String
reverseMaybe Nothing = Nothing
reverseMaybe (Just val) = Just (reverse val)

reverseMaybeV2 :: Maybe String
reverseMaybeV2 = reverse <$> sampleString