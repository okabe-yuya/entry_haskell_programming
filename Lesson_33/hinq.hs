import Control.Monad
import Control.Applicative
import GHC.Base (Alternative)

data Name = Name { firstName :: String, lastName :: String }

instance Show Name where
  show (Name first last) = mconcat [first, " ", last]

data  GradeLevel = Freshman | Sophomore | Junior | Senior deriving (Eq, Ord, Enum, Show)

data Student = Student {
  studentId :: Int,
  gradeLevel :: GradeLevel,
  studentName :: Name
} deriving Show

students :: [Student]
students = [
    Student 1 Senior (Name "Audre" "Lorde"),
    Student 2 Junior (Name "Leslie" "Silko"),
    Student 3 Freshman (Name "Judith" "Butler"),
    Student 4 Senior (Name "Guy" "Debord"),
    Student 5 Sophomore (Name "Jean" "Baudrilland"),
    Student 6 Junior (Name "Julia" "Kristeva")
  ]

data Teacher = Teacher {
  teacherId :: Int,
  teacherName :: Name
} deriving Show

teachers :: [Teacher]
teachers = [
    Teacher 100 (Name "Simone" "De Beauvior"),
    Teacher 200 (Name "Susan" "Sontag")
  ]

data Course = Course {
  courseId :: Int,
  courseTitle :: String,
  teacher :: Int
} deriving Show

courses :: [Course]
courses = [
    Course 101 "French" 100,
    Course 201 "English" 200
  ]

data Enrollment = Enrollment {
  student :: Int,
  course ::Int
} deriving Show

enrollments :: [Enrollment]
enrollments = [
    Enrollment 1 101,
    Enrollment 2 101,
    Enrollment 2 201,
    Enrollment 3 101,
    Enrollment 4 201,
    Enrollment 4 101,
    Enrollment 5 101,
    Enrollment 6 201
  ]

-- behavior as SELECT
-- _select :: (a -> b) -> [a] -> [b]
_select :: Monad m => (a -> b) -> m a -> m b
_select prop vals = do prop <$> vals

-- behavior as WHERE
-- _where :: (a -> Bool) -> [a] -> [a]
_where :: (Monad m, Alternative m) => (a -> Bool) -> m a -> m a
_where test vals = do
  val <- vals
  guard(test val)
  return val

-- behavior as JOIN
-- _join :: Eq c => [a] -> [b] -> (a -> c) -> (b -> c) -> [(a, b)]
_join :: (Monad m, Alternative m, Eq c) => m a -> m b -> (a -> c) -> (b -> c) -> m (a, b)
_join data1 data2 prop1 prop2 = do
  d1 <- data1
  d2 <- data2
  guard (prop1 d1 == prop2 d2)
  return (d1, d2)

_hinq selectQuery joinQuery whereQuery = (\joinData -> (\whereResult -> selectQuery whereResult) (whereQuery joinData)) joinQuery

data HINQ m a b = HINQ (m a -> m b) (m a) (m a -> m a) | HINQ_ (m a -> m b) (m a)

runHINQ :: (Monad m, Alternative m) => HINQ m a b -> m b
runHINQ (HINQ sClause jClause wClause) = _hinq sClause jClause wClause
runHINQ (HINQ_ sClause jClause) = _hinq sClause jClause (_where (\_ -> True))

query1 :: HINQ [] (Teacher, Course) Name
query1 = HINQ (_select (teacherName . fst))
              (_join teachers courses teacherId teacher)
              (_where ((== "English") . courseTitle . snd))

query2 :: HINQ [] Teacher Name
query2 = HINQ_ (_select teacherName) teachers

possibleTeacher :: Maybe Teacher
possibleTeacher = Just (head teachers)

possibleCourse :: Maybe Course
possibleCourse = Just (head courses)

maybeQuery1 :: HINQ Maybe (Teacher, Course) Name
maybeQuery1 = HINQ (_select (teacherName . fst))
                    (_join possibleTeacher possibleCourse teacherId teacher)
                    (_where ((== "French") . courseTitle . snd))

studentEnrollmentsQ = HINQ_ (_select (\(st, en) -> (studentName st, course en)))
                            (_join students enrollments studentId student)

studentEntrollments :: [(Name, Int)]
studentEntrollments = runHINQ studentEnrollmentsQ

-- startsWith :: Char -> String -> Bool
-- startsWith char string = char == head string

-- joinData :: [(Teacher, Course)]
-- joinData = _join teachers courses teacherId teacher

-- whereResult :: [(Teacher, Course)]
-- whereResult = _where ((== "English") . courseTitle . snd) joinData

-- selectResult :: [Name]
-- selectResult = _select (teacherName . fst) whereResult

-- finalResult :: [Name]
-- finalResult = _hinq (_select (teacherName . fst))
--                     (_join teachers courses teacherId teacher)
--                     (_where ((== "English") . courseTitle . snd))

-- teacherFirstName :: [String]
-- teacherFirstName = _hinq (_select firstName)
--                           finalResult
--                           (_where (\_ -> True))