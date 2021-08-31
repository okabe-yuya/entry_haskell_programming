import qualified Data.Map as Map
import GHCi.ObjLink (lookupClosure)

type UserName = String
type GamerId = Int
type PlayerCredits = Int
type WillCold = Int

userNameDB :: Map.Map GamerId UserName
userNameDB = Map.fromList [
    (1, "nYarlathoTep"),
    (2, "KINGinYELLOW"),
    (3, "dagon1997"),
    (4, "rcarter1919"),
    (5, "xCTHULHUx"),
    (6, "yogSOThoth")
  ]

creditDB :: Map.Map UserName PlayerCredits
creditDB = Map.fromList [
    ("nYarlathoTep", 2000),
    ("KINGinYELLOW", 15000),
    ("dagon1997", 300),
    ("rcarter1919", 12),
    ("xCTHULHUx", 50000),
    ("yogSOThoth", 150000)
  ]

gamerIdDB :: Map.Map WillCold GamerId
gamerIdDB = Map.fromList [
    (1001, 1),
    (1002, 2),
    (1003, 3),
    (1004, 4),
    (1005, 5),
    (1006, 6)
  ]

creditsFromId :: GamerId -> Maybe PlayerCredits
creditsFromId id = altLookupCredits (lookupUserName id)

lookupUserName :: GamerId -> Maybe UserName
lookupUserName id = Map.lookup id userNameDB

lookupCredits :: UserName -> Maybe PlayerCredits
lookupCredits name = Map.lookup name creditDB

lookupGamerId :: WillCold -> Maybe GamerId
lookupGamerId id = Map.lookup id gamerIdDB

altLookupCredits :: Maybe UserName -> Maybe PlayerCredits
altLookupCredits Nothing = Nothing
altLookupCredits (Just name) = lookupCredits name

monadCreditsFromId :: GamerId -> Maybe PlayerCredits
monadCreditsFromId id = lookupUserName id >>= lookupCredits

creditFromWCID :: WillCold -> Maybe PlayerCredits
creditFromWCID id = lookupGamerId id >>= lookupUserName >>= lookupCredits


allFmap :: Applicative f => (a -> b) -> f a -> f b
allFmap func a = pure func <*> a

allFmapM :: Monad m => (a -> b) -> m a -> m b
allFmapM func a = a >>= (\n -> return (func n))

bind :: Maybe a -> (a -> Maybe b) -> Maybe b
bind Nothing _ = Nothing
bind (Just a) func = func a