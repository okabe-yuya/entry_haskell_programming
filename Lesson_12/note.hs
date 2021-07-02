--eg: (Yamada, Tarou)
type FirstName = String
type LastName = String
type MiddleName = String
type Age = Int
type Height = Int
type PatientName = (String, String)

data Name = Name FirstName LastName 
            | NameWithMiddle FirstName MiddleName LastName

showName :: Name -> String 
showName (Name f l) = f ++ " " ++ l
showName (NameWithMiddle f m l) = f ++ " " ++ m ++ " " ++ l

patientInfo :: PatientName -> Age -> Height -> String
patientInfo (firstName, lastName) age height = "Name: " ++ firstName ++ lastName ++ " Age: " ++ show age ++ " Height: " ++ show height

-- Pos, Negに対する型定義は不要なよう
data Sex = Male | Female
data RhType = Pos | Neg
data ABOType = A | B | AB | O

-- type constructor
data BloodType = BloodType ABOType RhType

-- data Patient = Patient Name Sex Int Int Int BloodType
-- eg: jane = Patient (Name "Jane" "Elizabeth" "Smith") Female 25 74 200 (BloodType B Pos)

-- with record syntax
data Patient = Patient {
  name :: Name,
  sex :: Sex,
  age :: Int,
  height :: Int,
  weight :: Int,
  bloodType :: BloodType
}


patient1BT :: BloodType
patient1BT = BloodType A Pos

patient2BT :: BloodType
patient2BT = BloodType O Neg

patient3BT :: BloodType
patient3BT = BloodType AB Pos

showRh :: RhType -> String
showRh Pos = "+"
showRh Neg = "-"

showABO :: ABOType -> String 
showABO A = "A"
showABO B = "B"
showABO AB = "AB"
showABO O = "O"

showBloodType :: BloodType -> String
showBloodType (BloodType abo rh) = showABO abo ++ showRh rh

canDonateTo :: Patient -> Patient -> Bool 
canDonateTo pA pB = _canDonateTo (bloodType pA) (bloodType pB)

_canDonateTo :: BloodType -> BloodType -> Bool
_canDonateTo (BloodType O _) _ = True 
_canDonateTo (BloodType AB _) _ = True
_canDonateTo (BloodType A _) (BloodType A _) = True
_canDonateTo (BloodType B _) (BloodType B _) = True
_canDonateTo _ _ = False