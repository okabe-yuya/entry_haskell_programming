## Lesson1
対話型replの起動: `ghci`

## Lesson2
関数の振る舞いに関する制限
- 関数は常に引数を受け取らなければならない
- 関数は常に値を返さなければならない
- 同じ関数を同じ引数で呼び出した場合は常に同じ結果が返されなければならない

変数への値の束縛 -> `where` を使って表現
```haskell
doublePlusTwo x = doubleX + 2
  where doubleX = x * 2
```

## Lesson3
名前を持たない関数 -> ラムダ関数(eg: \x -> x * 2)
whereかletにて変数の宣言が可能 -> どちらがいいかは好みの問題

レキシカルスコープ -> 近いスコープの変数から値を参照していく。レキシカル = 順番にとかそういう意味合い
eg
```haskell
add10 n = (\n -> n + 10) n
-- add10 1 -> 11 ※20とはならない
```

IIFE -> レキシカルスコープを用いたスコープの範囲を限定的にするためのパターン
Immediately Invoked Function Expression
即時呼び出し関数式

## Lesson4
ファーストクラス関数(第一級関数) -> 関数を値として扱うことが出来る(eg: 戻り値、引数...)
関数を関数の引数として扱うことが出来る
- 処理する関数を引数として与える(eg: map, filter, reduceなど)
- 関数を戻り値として返す

関数は演算子よりも先に処理される
```haskell
inc n = n + 1
inc 2 * 3
-- 3 * 3 = 9
```

```haskell
-- 関数を引数に
ifEven myFunc x = if then x
                  then myFunc x
                  else x

inc n = n + 1
double n = n * 2
square n = n ^ 2

ifEvenInc n = ifEven inc n
ifEvenDouble n = ifEven double n
ifEvenSquare n = ifEven square n
```

戻り値として関数を返す
```haskell
getLocationFunction location = case location of
  "ny" -> nyFunc
  "sf" -> sfFunf
  "reno" -> renoFunc
  _ -> otherFunc

nyFunc x = ....
sfFunf x = ....
renoFunc x = ....
otherFunc x = ....
```

## Lesson5
- カリー化
- 部分適応
- クロージャ

ややこしいので整理

カリー化
```javascript
const sample = (x) => {
  return (y) => x * y;
};
```
クロージャ -> 引数を関数内に閉じ込めるやつ(カリー化もクロージャを利用している) -> 閉じ込めた時点でクロージャ。

部分適応。haskellでは呼び出し時に引数が足りていなくても、errorにならない。(仕組みのこと)
引数が部分適応される。
```haskell
add x y z = x * y * z
add1 = add 1
add1 3 4
```

カリー化(引数を部分適応出来る状態にした関数) -> カリー化された関数を用いて部分適応がされる -> 🎉

filpBinaryArgs -> 受け渡す引数の順序を入れ替えて部分適応させることが出来る
```haskell
addressLetter name location = locationFunction name
  where locationFunction = getLocationFunction location

addressLetterV2 = flipBinaryArgs addressLetter
addressLetterNY = addressLetterV2 "ny"
*Main> addressLetterNY ("Bob", "Smith")
```

## Lesson6
リストは再帰的 head, tail, [] -> 関数型プログラミングの中枢を成す
リストの構成(: -> コンス(construct))
1 : []

全てのリストは空リストに対してのコンスで表現可能

- :(コンス)
- ++(append)
- lst !! n(index_at)

遅延評価
[1 .. ]　としてもerrorにならない

部分適応された関数が帰ってくる -> 引数1なので`catAt`で引数を用意する必要はない
```haskell
catAt1 n = "cat" !! n
catAt2 = (!!) "cat"
catAt3 = (!! 2) -- 右オペランドの部分適応がされて左オペランドの値を待機する
-- catAt3 "cat"
```

中置演算
```haskell
elem 'c' "cat"
'c' `elem` "cat"
```

## Lesson7
再帰のルール
- 最終目標を決定 -> 停止性の議論
- 最終目標の場合にどうするか決める
- 他の条件を洗い出す
- 繰り返すごとに最終目標に近づくように

```haskell
-- eg: listの抽出
lst = [1,2,3]
head lst -- 1
next = tail lst -- [2, 3]

-- next
head next -- 2
tail -- [3]
```

強力なパターンマッチ。あくまで引数に対してのパターンマッチであり、ガード節のような条件式を用いることは出来ない
-> 現状の対処としては関数のネストをして、引数経由でbooleanに変換するとか？

haskellでは監修的にリストのパターンマッチを以下のように記述することが多いとのこと
```haskell
tail (x:xs) = xs
tail [] = []
```

## Lesson8
:set +sとすることでrepl上で実行速度を計測することができる

コンスでのリスト作成は x: []である必要がある
```haskell
myCycle (x:xs) = x:myCycle (x:xs)
```

reverseを作る場合には、[] : xとなるためコンスを用いることが出来ない
```haskell
myReverse [] = []
myReverse (x:xs) = (myReverse xs) ++ [x]
```

## Lesson9
高階関数 -> 厳密には別の関数を引数として受け取れる関数(eg: map, filter, reduce...)

- foldl -> 左畳み込み eg: foldl (-) 0 [1,2,3,4] -> -10
- foldr -> 右畳み込み eg: foldr (-) 0 [1,2,3,4] -> -2

### foldrの動き
```haskell
-- eg: args (+) 0 [1,2,3,4,5]
myFoldr (+) 0 (1:[2,3,4,5]) = (+) next 1
next = myFoldr (+) 0 [2,3,4,5]

myFoldr (+) 0 [2,3,4,5] = (+) next 2
next = myFoldr (+) 0 [3,4,5]

myFoldr (+) 0 [3,4,5] = (+) next 3
next = myFoldr (+) 0 [4,5]

myFoldr (+) 0 [4,5] = (+) next 4
next = myFoldr (+) 0 [5]

myFoldr (+) 0 [5] = (+) next 5
next = myFoldr (+) 0 []

myFoldr (+) 0 [] = 0

0 + 5 + 4 + 3 + 2 + 1 という順序で処理が実行される
```

harmonicは全然分からんかった
zip -> zip [1] [2] -> [(1, 2)]

こういうのが発想にまだない
```haskell
zip (cycle [1.0]) [1.0, 2.0 ..]
-- [1.0]を作り続ける無限リスト
-- [1.0, 2.0, 3.0, 4.0...]のように+1.0ずつを作り続ける無限リスト
```

## Lesson10
関数型プログラミングでのオブジェクトの概念の実装
- クロージャを使って内部stateを保持させる
- 値の更新があった時は、新たなクロージャを返して、stateが更新されたように見せかける
- クロージャに関数を受け渡せるようにすることで、インスタンスの関数として振る舞わせることが出来る

```haskell
cup flOz = \message -> message flOz
getOz aCup = aCup (\flOz -> flOz)
-- Oz -> オンスのこと(単位)

coffeeCup = cup 12
-- \message -> message 12
getOz coffeeCup
-- getOz \message -> message 12 = \message -> message 12 (\flOz -> flOz)
-- getOz \message -> message 12 = \flOz -> flOz 12
-- 12がmessage経由で受け取った関数の引数に格納されるため、値の取得が出来る 
```

JavaScriptでの動作を見て納得
```javascript
const cup = (flOz) => (message) => message(flOz);
const getOz = (aCup) => aCup((flOz) => flOz);

const coffeeCup = cup(12);
const ammount = getOz(coffeeCup);
console.log(ammount); // 12
```

## Lesson11
Hakellでは強力な型推論がサポートされている。

```
ポリモーフィズム（英: Polymorphism）とは、プログラミング言語の型システムの性質を表すもので、プログラミング言語の各要素（定数、変数、式、オブジェクト、関数、メソッドなど）についてそれらが複数の型に属することを許すという性質を指す。
```

関数における型シグネチャの記述

`double :: Int -> Int`
(eg: dobuleはInt型の引数を1つ受け取り、Int型の値を1つ返す)

こんな感じの型指定もいける
`read "6" :: Int` (readは文字列を別の型に変換する関数)

関数を引数で受け取る際の型定義
```haskell
ifEven :: (Int -> Int) -> Int -> Int
ifEven f n = if even n
              then f n
              else n
```

`TypeScript` での`T`のようなジェネリックのような型シグネチャ
```haskell
simple :: a -> b -> c -> Int
simple a b n = ....
```

ここでaとbとcの型は異なる。aが2回登場する場合には型が揃っている必要がある
```haskell
simple :: a -> b -> a -> Int
simple a b n = ....
```

filterの型シグネチャ
```haskell
filter :: (a -> Bool) -> [a] -> [a]
```

myFoldlの型シグネチャ
```haskell
myFoldl :: (a -> b) -> b -> [a] -> b
myFoldl :: (a -> b -> a) -> a -> [b] -> a -- 正解はこれ！おしい！
```

## Lesson12
型シノニム -> 1つの型に対して別の名前を割り当てることが出来る

```haskell
type FirtName = String
type LastName = String

fullName :: FirstName -> LastName -> [Char]
```

任意の型の作成 -> 型シノニムでも可能だが、任意の型を作成すると強力なパターンマッチの力を引き出すことが出来る
```haskell
data RhType = Pos | Neg
data ABOType = A | B | AB | O

showRh :: RhType -> String
showRh Pos = "+"
showRh Neg = "-"

showABO :: ABOType -> String 
showABO A = "A"
showABO B = "B"
showABO AB = "AB"
showABO O = "O"

-- type constructor -> 複数の型を組み合わせる際には必要
data BloodType = BloodType ABOType RhType
showBloodType :: BloodType -> String
showBloodType (BloodType abo rh) = showABO abo ++ showRh rh
```

レコード構文を用いることで、型の順序、getter, setterを自動生成してくれる

## Lesson13
型クラス -> 他言語における`interface`に似たもの。関数に共通の定義を与えることが出来る

こういうやつ(`:t (+)`)
`Num => a`

深堀。
```haskell
:info Num
class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a -> a
```

## Lesson14
`class`がinterface(型クラス)に近いもの。カスタム型を定義する時に、継承することが出来る？？
```haskell
-- クラスのインスタンスの自動生成
data Someone = A | B deriving (Show)
```

ポリモーフィズム -> 型によって振る舞いが変わる(string型では... int型では...)
データコンストラクタ -> eg: `data Sex = Male | Female` の`Male`と`Female`がそれ

継承していない型クラスへの振る舞いはインスタンスを定義して決める必要がある
```haskell
data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Eq, Ord)

-- 独自の振る舞いを定義することが出来る
instance Show SixSideDie where
  show S1 = "Ⅰ"
  show S2 = "Ⅱ"
  show S3 = "Ⅲ"
  show S4 = "Ⅳ"
  show S5 = "Ⅴ"
  show S6 = "Ⅵ"
```
 
以下の場合だと、エラーになる。(インスタンスと継承している型クラスが重複したため)
```haskell
data SixSideDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Eq, Ord)
instance Eq SixSideDie where
  (==) S6 S6 = True
  (==) S5 S5 = True
  (==) S4 S4 = True
  (==) S3 S3 = True
  (==) S2 S2 = True
  (==) S1 S1 = True
  (==) _ _ = False
```

作成したカスタム型を持つ、変数の作成。showを継承していないと、出力出来ない
```haskell
-- いまさらだけど
sample1 = One
sample2 = Two
```

型クラスの定義 -> classの要求(スーパークラスの定義)
EqはOrdのスーパークラスとなる
```haskell
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  :
  :

-- EnumとEqがスーパークラス
class (Enum a, Eq a) => Die a where
  roll :: Int -> a
```

classを定義したら、振る舞いを定義する(インスタンス)必要がある
```haskell
class (Enum a, Eq a) => Die a where
  roll :: Int -> a

instance Die FiveSideDie where
  roll n = toEnum (n `mod` 5)
```

## Lesson16
代数的データ型 -> 他の型を組み合わせることで作成できる型
ANDかORによって作成される
- ANDで作られる型(String && String) -> 直積型(構造体とかJsonとかもそうだよ)
  - 分子と分母で作られる分数
  - 番地とストリート名として定義できる番地コード
- ORで作られる型(String | Number) -> 直和型
  - Bool = False | True

直積型の呪い -> 階層的な設計を強いられる。共通化として継承を選択するしかない。 -> 増えれば増えるほど、共通化出来る項目は少なくなっていく

```haskell
data StoreItem = BookItem Book
                  | RecordItem VinylRecord
                  | ToyItem CollectibleToy
                  | PamphletItem Pamphlet

data Phamplet = Phamplet {
  title :: String,
  description :: String,
  contact :: String,
  phampletPrice :: Double,
}
```

複数の項目がある場合(直積型)には、`BookItem Book`と宣言する。項目が少ないor1つの場合には`data Shape = Circle Radius`と出来る

## Lesson17
合成可能性 -> 似たような2つを組み合わせる
関数合成 -> composeという高階関数(`.`)によって可能
```haskell
myLast :: [a] -> a
-- myLastにて引数を受け取って関数に受け渡す記述が必要なくなる
myLast = head . reverse
```

Semigroup良くわからん
`Semigroup`というは`<>`だけを定義した型。型同士の結合のみをサポート。絵の具の色を組み合わせて別の色を作る概念と似ている。

ガード節を使って、関数内の処理を切り分けることも可能
```haskell
myFunc a b | a == b = "goodmorning" | otherwise "hello"
```

Monoid -> 良くわからんけど、単位元を要求するSemigroup
単位元
- Interger = 0
- List = []

演算子しても結果に影響を与えないもの？

すげぇ！単純な結合によってパワフルな結果を得られる。
(ただし、実務レベルの場合にどこで使えばいいのか良く分かっていない)
```haskell
mconcat [coin, coin, coin]
heads-heads-heads | 0.125
heads-heads-tails | 0.125
heads-tails-heads | 0.125
heads-tails-tails | 0.125
tails-heads-heads | 0.125
tails-heads-tails | 0.125
tails-tails-heads | 0.125
tails-tails-tails | 0.125
```

`Semigroup`と`Monoid`の目的 -> 同じ型の2つのインスタンスを組み合わせて1つのインスタンスにすること
`Monoid`の場合には単位元を要求する(eg: [1,2,3] ++ [] = [1,2,3])
`Semigroup`は単位元を要求しない(eg: [1,2,3] ++ [4,5,6] = [1 .. 6])

### q1
```haskell
data Color = Red | Yellow | Blue | Green | Purple | Orange | Brown | Clear deriving (Show, Eq)
instance Semigroup Color where
  (<>) Clear any = any
  (<>) any Clear = any
  :
  :

instance Monoid Color where
  mempty = Clear
  mappend c1 c2 = c1 <> c2
```

## Lesson18
保存するの忘れた吹き飛んだ＼(^ q ^)／

## Lesson19
`Maybe`を使うことで多くの言語で発生する`null`問題(nullエラー)を完全に消し去ることが出来るらしい。

```haskell
data Maybe = Nothing | Just a
```

Nothing -> 存在しない
Just a -> aの型の値が存在した

また`Maybe`は`Eq`を実装しているので、比較も簡単に行うことで出来る
```haskell
nothings :: [Maybe Organ] -> Int
nothings organs = length ((filter \x -> x == Nothing) organs)
```

`Maybe`を用いることで関数から値が存在しない場合の処理を完全に取り除く事ができる。
絶対に値が存在する場合の処理に集中することが出来る。
ただし上層の関数では`Maybe`になることを想定した処理(eg: パターンマッチを用いる)を記述することになるので
完全に、問題が取り払われるわけではない。
ただ、これはコンパイル時に型チェックで防ぐことが出来るので、実装の労力が必要がだが`null`問題を除去することが出来ると等しい

## Lesson20
TSではあらゆる型をサポートするため`a`を引数として受け取る。さらに欠損値に対応したい(他言語でいうnullの可能性がある)ので`Maybe`を使う
```haskell
data TS a = TS [Int] [Maybe a]
```

## Lesson21
IOについて。HaskellではIOという型を提供している。
IOとStringなどとの結合は不可能。

```haskell
IO () -- () は空のタプル。IOへのパラメーター
```

```haskell
main :: IO ()
main = do
```
これは関数ではない。意味のある値を返さないから。
mainはI/Oアクションとして扱われる。
I/OアクションはI/Oアクションを呼び出すことが可能。逆も然り。
ただし関数からI/Oアクションを呼び出すことは出来ない(mainの中では可能 -> I/Oアクションだから)

`a <- getLine`とすることで`IO String`を`main`の内部で`String`として扱うことが出来る

## Lesson22
main関数には制約がある?
`IO ()`しか返せないっぽい

なぜ`map_`はダメなのか。 -> `putStrLn`が`IO`だからだと考えられる。
```haskell
:info putStrLn
putStrLn :: String -> IO ()     -- Defined in ‘System.IO’
```

こんなパターンマッチも出来るのか
```haskell
calc :: [String] -> Int
calc (val1:"+":val2:_) = read val1 + read val2
calc (val1:"*":val2:_) = read val1 * read val2
```

## Lesson23
`String`型だと効率よく処理が出来ない場合がある -> リンクリストであるため、indexが必ずしもメモリ上で連番にならない
`Text`型であれば、配列として値が格納されるため高速化される場合がある & 遅延評価されない

拡張機能のimportが可能
```haskell
{-# LANGUAGE extension #-}
```

## Lesson24
`System.IO`によってファイルの入力/出力を行う。
遅延I/Oとして実行されるため、必ずしも上から下へと順に実行されるわけでは無い。
そのためcloseをすることで、まだ評価がされていない変数が使用不可になったりするので、遅延I/Oは扱いが難しい。

```haskell
import System.IO

main :: IO ()
main = do
  file <- openFile "hoge.txt" ReadMode
  input <- hGetContents file
  hClose fiie -- closeは直ちに実行されるためfileへの参照が無くなる(参照という言葉が正確かは不明)

  putStrLn input -- すでにcloseされてしまっているためエラーとなる -> 遅延評価のため、ここにきて初めてinputは評価される
```

## Lesson25
ByteStringはByteの配列であり、String
StringはCharのリスト

特になし。Byte操作する際に参照すればいいかなという程度

## Lesson26
演習のため省略

## Lesson27
Functor, Applicative, Monadは何をするのか
(String) -> (Int) に変換する関数がある場合に
(Maybe String) -> (Maybe Int)...のような関数を全ての定義された関数に対してMaybeでラップされた関数を用意するのはしんどい。
なので、Functor, Applicative, Monadを使って楽にしようという考えだと思われる。

Functor: String -> Int
コンテキストの内部に対して関数を適応させることが出来る。
eg: Maybe Int -> Maybe Int
```haskell
sample :: Maybe Int
sample = Just 999

plus1 :: Int -> Int
plus1 n = n + 1

fmap plus1 sample -- Just 1000
```

Maybeに対するFunctorのinterface
```haskell
instance Functor Maybe where
  fmap func (Just n) = Just (func n)
  fmap func Nothing = Nothing
```

二項演算子を用いる
```haskell
successStr :: Maybe String
successStr = show <$> (Just 6)

-- Main> successStr
-- Just "6"
```

以下の2つは同じ動作をする
```
allParts = snd <$> Map.toList partsDB
allParts = fmap snd Map.toList partsDB
```

Functor
- List
- Map
- Maybe
- IO
に対して定義されている。それぞれの型で振る舞いが変わる
> https://hackage.haskell.org/package/base-4.15.0.0/docs/GHC-Base.html

Functorを使うことで、IOを取り出すことが出来なくても、IOの値をコンテキスト内部で更新することが出来る
```haskell
action :: IO Int -> IO String
action ioInt = fmap show ioInt
```

したがって、コンテキストを持つ型に対してFunctorは非常に強力
fmapに渡す関数を作る時はコンテストがない状態をイメージすると分かりやすい。(当然だけど)

## Lesson28
Applicative -> 長い計算を結合することができる。Functorで出来ないことを解決するためにある

Maybeが混在する場合に、Maybeの連続に対して処理を割り当てたい時がある
```haskell
haversineMaybe :: Maybe LatLong -> Maybe LatLong -> Maybe Double
haversineMaybe Nothing _ = Nothing
haversineMaybe _ Nothing = Nothing
haversineMaybe (Just l1) (Just l2) = Just(haversine l1 l2)
```

しかし、同じような関数全てにラッパーを定義する必要が発生する。
別途、IOのようなコンテキストにはラッパーをまた定義しなければならない。

fmapの制限 -> 引数が1つの関数にしか対応できない。複数の引数を持つ場合に呼び出せない

```haskell
applicative :: f (a -> b) -> f a -> f b
```

例:
```haskell
start = Map.lookup "Carcosa" locationDB
end = Map.lookup "Innsmouth" locationDB
haversine <$> start <*> end

-- haversine <$> start は部分適応がされてMaybe Doubleが返る
-- partialHaversine :: Maybe Double -> Maybe Double
-- partialHaversine <$> end と同じ状態になる
```

要するに引数への部分適応を行った関数に対してチェインして引数を受け渡して処理するための関数を持つクラスがApplicative

Applicativeによってこれがこうじゃ
```haskell
haversineIO :: IO LatLong -> IO LatLong -> IO Double
haversineIO v1 v2 = do
  val1 <- v1
  val2 <- v2
  let distance = haversine val1 val2
  return distance

haversineIO2 :: IO LatLong -> IO LatLong -> IO Double
haversineIO2 v1 v2 = haversine <$> v1 <*> v2
```

## Lesson29
```haskell
*Main T> :info <*>
type Applicative :: (* -> *) -> Constraint
class Functor f => Applicative f where
  ...
  (<*>) :: f (a -> b) -> f a -> f b
  ...
```

pureメソッド -> コンテキストの内部に通常の値を格納してくれる
```haskell
class Functor f => Applicative f where
  pure :: a -> f a
```

```haskell
*Main> :t pure "Hello World!" :: IO String
:: IO String
```

つまり通常の型の値をコンテキストの世界へ導いてくれるのだ

Listはコンテナでありコンテキスト。コンテナとコンテキストの違いは...??

以下は同義らしい
```haskell
*Main> fmap (+) [1000, 2000, 3000] <*> [500, 20000]
[1500,21000,2500,22000,3500,23000]

*Main> (+) <$> [1000, 2000, 3000] <*> [500, 2000]
[1500,3000,2500,4000,3500,5000]

*Main> pure (+) <*> [1000, 2000, 3000] <*> [500, 20000]
[1500,21000,2500,22000,3500,23000]
```

pureはApplicateの型クラスへ強制変換している??
```haskell
*Main> :t pure (+)
pure (+) :: (Prelude.Applicative f, Num a) => f (a -> a -> a)
```

- コンテナ: 見れば何の値が入っているか分かる。何らかの要素を持つか、空
- コンテキスト: 何らかの値が入っているかもしれない。可能性の集合

Listを非決定論の視点で捉えるとコンテキストして扱うことになる。
```haskell
(+) -- 決定論
pure (+) -- 非決定論
```

## Lesson30
ようやくMonad。
このような場合にどうなるか

```haskell
type UserName = String
type PlayerCredits = Int

Maybe UserName -> (UserName -> Maybe PlayerCredits) -> Maybe PlayerCredits
```

```haskell
(<$>) :: Functor f => (a -> b) -> f a -> f b
(<*>) :: Applicative f => f (a -> b) -> f a -> f b
pure :: Applicative f => a -> f a
```

これだとMaybeのような単純にコンテキストを取り出せる型にはラップ関数を作れば対応出来るが、
IOのようなコンテキスト内の値を操作するのが難しい(FunctorとApplicativeを使う必要がある)場合には難しい。

```haskell
altLookupCredits :: Maybe UserName -> Maybe PlayerCredits
altLookupCredits Nothing = Nothing
altLookupCredits (Just name) = lookupCredits name
```

そのためにMonadが必要！

bind
```haskell
(>>=) :: Monad m => m a -> (a -> m b) -> m b
```

```haskell
lookupUserName :: GamerId -> Maybe UserName
lookupUserName id = Map.lookup id userNameDB

lookupCredits :: UserName -> Maybe PlayerCredits
lookupCredits name = Map.lookup name creditDB

monadCreditsFromId :: GamerId -> Maybe PlayerCredits
monadCreditsFromId id = lookupUserName id >>= lookupCredits
```

つまり、コンテキストから値を無理矢理取り出して、その値を次の関数に受け渡していくのがMonadだ

```haskell
(>>=) :: m a -> (a -> m b) -> m b -- コンテキストから取り出した値を関数に適応させる
(>>) :: m a -> m b -> m b -- 一つ目の引数のコンテキストを破棄する eg: putStrLn >> getLine
return :: a -> m a -- Applicativeのpureと同じ。歴史的背景から別名が付いている
```
