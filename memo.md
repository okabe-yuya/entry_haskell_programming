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
こういうやつ
```javascript
const sample = (x) => {
  return (y) => x * y;
};
```
クロージャ -> 引数を関数内に閉じ込めるやつ(カリー化もクロージャではある)

部分適応
こういうやつ
```haskell
add x y z = x * y * z
add1 = add 1
add1 3 4
```