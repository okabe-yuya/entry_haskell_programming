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
-- 3 * 3 = 9```
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
ifEvenSquare n = ifEven square n```
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
クロージャ -> 引数を関数内に閉じ込めるやつ(カリー化もクロージャではある)

部分適応。haskellでは呼び出し時に引数が足りていなくても、errorにならない。
引数が部分適応される。
```haskell
add x y z = x * y * z
add1 = add 1
add1 3 4
```

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