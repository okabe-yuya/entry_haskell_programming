addressLetter name location = locationFunction name
  where locationFunction = getLocationFunction location

getLocationFunction location = case location of 
  "ny" -> nyOffice
  "sf" -> sfOffice
  "reno" -> renoOffice
  "dc" -> dcOffice
  _ -> (\name -> (fst name) ++ " " ++ (snd name))

sfOffice name = let lastName = snd name
                in
                  let nameText = (fst name) ++ " " ++ lastName
                  in
                    if lastName < "L"
                    then nameText ++ " - PO Box 1234 - San Francisco, CA, 94111"
                    else nameText ++ " - PO Box 1010 - San Francisco, CA, 94109"

nyOffice name = let nameText = (fst name) ++ " " ++ (snd name)
                in
                  nameText ++ ": PO Box 789 - New York, NY, 10013"

renoOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
  where nameText = snd name

dcOffice name = nameText ++ " Esq"
  where nameText = snd name