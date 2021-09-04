import qualified Data.Map as Map

data Grade = F | D | C | B | A deriving (Eq, Ord, Show, Read)
data Degree = HS | BA | MS | PhD deriving (Eq, Ord, Enum, Show, Read)
data Candidate = Candidate {
  candidateId :: Int,
  codeReview :: Grade,
  cultureFit :: Grade,
  education :: Degree
}

candidate1 :: Candidate
candidate1 = Candidate { candidateId = 1, codeReview = A, cultureFit = A, education = BA }

candidate2 :: Candidate
candidate2 = Candidate { candidateId = 2, codeReview = C, cultureFit = A, education = PhD }

candidate3 :: Candidate
candidate3 = Candidate { candidateId = 3, codeReview = A, cultureFit = B, education = MS }

candidateDB :: Map.Map Int Candidate
candidateDB = Map.fromList [(1, candidate1), (2, candidate2), (3, candidate3)]

candidates :: [Candidate]
candidates = [candidate1, candidate2, candidate3]

viable :: Candidate -> Bool
viable candidate = all (== True) tests
  where passedCoding = codeReview candidate > B
        passCultureFit = cultureFit candidate > C
        educationMin = education candidate >= MS
        tests = [passedCoding, passCultureFit, educationMin]

readInt :: IO Int
readInt = getLine >>= \v -> return (read v)

readGrade :: IO Grade
readGrade = getLine >>= \v -> return (read v)

readDegree :: IO Degree
readDegree = getLine >>= \v -> return (read v)

readCandidate :: IO Candidate
readCandidate = do
  putStrLn "enter id:"
  cId <- readInt
  putStrLn "enter code grade:"
  codeGrade <- readGrade
  putStrLn "enter culture fit grade:"
  cultureGrade <- readGrade
  putStrLn "enter education:"
  degree <- readDegree
  return ( Candidate { candidateId = cId, codeReview = codeGrade, cultureFit = cultureGrade, education = degree } )

assessCandidateIO :: IO String
assessCandidateIO = do
  candidate <- readCandidate
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

assessCandidateMaybe :: Int -> Maybe String
assessCandidateMaybe cId = do
  candidate <- Map.lookup cId candidateDB
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

assessCandidateList :: [Candidate] -> [String]
assessCandidateList candidates = do
  candidate <- candidates
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

assessCandidate :: Monad m => m Candidate -> m String
assessCandidate candidates = do
  candidate <- candidates
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

main :: IO ()
main = do
  assessCandidateIO >>= putStrLn