cup flOz = \message -> message flOz
getOz aCup = aCup (\flOz -> flOz)
-- drink aCup ozDrink = cup (flOz - ozDrink)
--   where flOz = getOz aCup

drink aCup ozDrink = if ozDiff >= 0
                     then cup ozDiff
                     else cup 0
  where flOz = getOz aCup
        ozDiff = flOz - ozDrink

-- robot
robot (name, attack, hp) = \message -> message (name, attack, hp)
name (name, _, _) = name
attack (_, attack, _) = attack
hp (_, _, hp) = hp

getName aRobot = aRobot name
getAttack aRobot = aRobot attack
getHp aRobot = aRobot hp

setName aRobot newName = aRobot (\(_, a, h) -> robot (newName, a, h))
setAttack aRobot newAttack = aRobot (\(n, _, h) -> robot (n, newAttack, h))
setHp aRobot newHp = aRobot (\(n, a, _) -> robot (n, a, newHp))

printRobot aRobot = aRobot (\(n, a, h) -> n ++
                                          " attack:" ++ (show a) ++
                                          " hp:" ++ (show h))

damage aRobot attackDamage = aRobot (\(n, a, h) -> robot (n, a, h - attackDamage))

fight aRobot defender = damage defender attack
  where attack = if getHp aRobot > 10
                 then getAttack aRobot
                 else 0

allHp aRobots = map getName aRobots
