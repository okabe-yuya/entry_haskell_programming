import qualified Data.Map as Map

type Html = String
data RobotPart = RobotPart {
  name :: String,
  description :: String,
  cost :: Double,
  count :: Int
} deriving Show

leftArm :: RobotPart
leftArm = RobotPart {
  name = "left arm",
  description = "left arm for face punching!",
  cost = 1000.00,
  count = 3
}

rightArm :: RobotPart
rightArm = RobotPart {
  name = "right arm",
  description = "right arm for kind hand gestures",
  cost = 1025.00,
  count = 5
}

robotHead :: RobotPart
robotHead = RobotPart {
  name = "robot head",
  description = "this head looks mad",
  cost = 5092.25,
  count = 2
}

renderHtml :: RobotPart -> Html
renderHtml part = mconcat [
    "<h2>", partName, "</h2>",
    "<p><h3>desc</h3>", partDesc, "</p>",
    "<p><h3>cont", partCost, "</h3></p>",
    "<p><h3>count", partCount, "</h3></p>"
  ]
  where partName = name part
        partDesc = description part
        partCost = show (cost part)
        partCount = show (count part)

partsDB :: Map.Map Int RobotPart
partsDB = Map.fromList keyVals
  where keys = [1, 2, 3]
        vals = [leftArm, rightArm, robotHead]
        keyVals = zip keys vals

partVal :: Maybe RobotPart
partVal = Map.lookup 1 partsDB

partHtml :: Maybe Html
partHtml = renderHtml <$> partVal

allParts :: [RobotPart]
allParts = snd <$> Map.toList partsDB

allPartsHtml :: [Html]
allPartsHtml = renderHtml <$> allParts

htmlPartsDB :: Map.Map Int Html
htmlPartsDB = fmap renderHtml partsDB


leftArmIO :: IO RobotPart
leftArmIO = return leftArm

htmlSnippet :: IO Html
htmlSnippet = renderHtml <$> leftArmIO
