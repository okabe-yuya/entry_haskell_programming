-- doubleDouble x = dubs * 2
  -- where dubs = x * 2

doubleDouble x = (\x1 -> x1 * 2) x * 2

-- lambda overwrite
overwrite x = (\x3 -> (\x2 -> (\x1 -> 4) 3) 2) x

-- counter x = ((\x -> x) ((\x -> x + 1) (\x -> x + 1) x)
counter x = (\x -> x + 1)
              ((\x -> x + 1)
                ((\x -> x) x))

counterN n = (\n -> n + 1)
              ((\n -> n) n)

-- caused error pattern
-- counter x = let x = x + 1
--             in
--               let x = x + 1
--               in
--                 (\x -> x) x