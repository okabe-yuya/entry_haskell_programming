{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString as B
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified Data.Text.Encoding as E
import Data.Maybe
import GHC.Base (Char)

type Author = T.Text
type Title = T.Text
type Html = T.Text

data Book = Book { author :: Author, title :: Title } deriving Show

book1 :: Book
book1 = Book { title = "The Conspiracy Against the Human Race", author = "Ligotti, Thomas" }

book2 :: Book
book2 = Book { title = "A Short History of Decay", author = "Cioran, Emil" }

book3 :: Book
book3 = Book { title = "The Tears of Eros", author = "Betaille, Georges" }

myBooks :: [Book]
myBooks = [book1, book2, book3]

bookToHtml :: Book -> Html
bookToHtml book = mconcat [ "<p>\n", titleInTags, authorInTags, "</p>\n" ]
  where titleInTags = mconcat [ "<strong>", title book, "</strong>\n" ]
        authorInTags = mconcat [ "<em>", author book, "</em>\n" ]

booksToHtml :: [Book] -> Html
booksToHtml books = mconcat [
                      "<html>\n",
                      "<head><title>books</title>",
                      "<meta charset='utf-8'/>",
                      "</head>\n",
                      "<body>\n",
                      booksHtml,
                      "\n</body>\n",
                      "</html>"
                    ]
  where booksHtml = (mconcat . map bookToHtml) books


type MarcRecordRaw = B.ByteString
type MarcLeaderRaw = B.ByteString
type MarcDirecotryRaw = B.ByteString
type MarcDirecotryEntryRaw = B.ByteString
type FieldText = T.Text
data FieldMetaData = FieldMetaData {
  tag :: T.Text,
  fieldLength :: Int,
  fieldStart :: Int
} deriving Show

leaderLength :: Int
leaderLength = 24

dirEntryLength :: Int
dirEntryLength = 12

fieldDelimiter :: Char
fieldDelimiter = toEnum 31

titleTag :: T.Text
titleTag = "245"

titleSubField :: Char
titleSubField = 'a'

authorTag :: T.Text
authorTag = "100"

authorSubField :: Char
authorSubField = 'a'

rawToInt :: B.ByteString -> Int
rawToInt = read . T.unpack . E.decodeUtf8

getLeader :: MarcRecordRaw -> MarcLeaderRaw
getLeader = B.take leaderLength

getRecordLength :: MarcLeaderRaw -> Int
getRecordLength leader = rawToInt (B.take 5 leader)

getBaseAddress :: MarcLeaderRaw -> Int
getBaseAddress leader = rawToInt (B.take 5 remainder)
  where remainder = B.drop 12 leader

getDirectoryLength :: MarcLeaderRaw -> Int
getDirectoryLength leader = getBaseAddress leader - (leaderLength + 1)

getDirectory :: MarcRecordRaw -> MarcDirecotryRaw
getDirectory record = B.take directoryLength afterLeader
  where directoryLength = getDirectoryLength record
        afterLeader = B.drop leaderLength record

splitDirectory :: MarcDirecotryRaw -> [MarcDirecotryEntryRaw]
splitDirectory directory = if directory == B.empty
                          then []
                          else nextEntry : splitDirectory restEntries
  where (nextEntry, restEntries) = B.splitAt dirEntryLength directory

makeFieldMetadata :: MarcDirecotryEntryRaw -> FieldMetaData
makeFieldMetadata entry = FieldMetaData textTag theLength theStart
  where (theTag, rest) = B.splitAt 3 entry
        textTag = E.decodeUtf8 theTag
        (rawLength, rawStart) = B.splitAt 4 rest
        theLength = rawToInt rawLength
        theStart = rawToInt rawStart

getTextField :: MarcRecordRaw -> FieldMetaData -> FieldText
getTextField record fieldMetaData = E.decodeUtf8 byteStringValue
  where recordLength = getRecordLength record
        baseAddress = getBaseAddress record
        baseRecord = B.drop baseAddress record
        baseAtEntry = B.drop (fieldStart fieldMetaData) baseRecord
        byteStringValue = B.take (fieldLength fieldMetaData) baseAtEntry

getFieldMetaData :: [MarcDirecotryEntryRaw] -> [FieldMetaData]
getFieldMetaData = map makeFieldMetadata

lookupFieldMetaData :: T.Text -> MarcRecordRaw -> Maybe FieldMetaData
lookupFieldMetaData aTag record = if length results < 1
                                  then Nothing
                                  else Just (head results)
  where metadata = (getFieldMetaData . splitDirectory . getDirectory) record
        results = filter ((== aTag) . tag) metadata

lookupSubfield :: Maybe FieldMetaData -> Char -> MarcRecordRaw -> Maybe T.Text
lookupSubfield Nothing _subfield _record = Nothing
lookupSubfield (Just fieldMetaData) subField record =
    if results == []
    then Nothing
    else Just ((T.drop 1 . head) results)
  where rawField = getTextField record fieldMetaData
        subfields = T.split (== fieldDelimiter) rawField
        results = filter ((== subField) . T.head) subfields

lookupValue :: T.Text -> Char -> MarcRecordRaw -> Maybe T.Text
lookupValue aTag subfield record = lookupSubfield entryMetadata subfield record
  where entryMetadata = lookupFieldMetaData aTag record

lookupTitle :: MarcRecordRaw -> Maybe Title
lookupTitle = lookupValue titleTag titleSubField

lookupAuthor :: MarcRecordRaw -> Maybe Author
lookupAuthor = lookupValue authorTag authorSubField

nextAndRest :: B.ByteString -> (MarcRecordRaw, B.ByteString)
nextAndRest marcStream = B.splitAt recordLength marcStream
  where recordLength = getRecordLength marcStream

allRecords :: B.ByteString -> [MarcRecordRaw]
allRecords marcStream = if marcStream == B.empty
                        then []
                        else next : allRecords rest
  where (next, rest) = nextAndRest marcStream

marcToPairs :: B.ByteString -> [(Maybe Title, Maybe Author)]
marcToPairs marcStream = zip titles authors
  where records = allRecords marcStream
        titles = map lookupTitle records
        authors = map lookupAuthor records

pairToBooks :: [(Maybe Title, Maybe Author)] -> [Book]
pairToBooks pairs = map (\(title, author) -> Book {
      title = fromJust title,
      author = fromJust author
    }) justPairs
  where justPairs = filter (\(title, author) -> isJust title && isJust author) pairs

processRecords :: Int -> B.ByteString -> Html
processRecords n = booksToHtml . pairToBooks . take n . marcToPairs

main :: IO ()
main = do
  marcData <- B.readFile "Lesson_26/sample.mrc"
  let processed = processRecords 500 marcData
  TIO.writeFile "Lesson_26/books.html" processed
  print "all done !"
