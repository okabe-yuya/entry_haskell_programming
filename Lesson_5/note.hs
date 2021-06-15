ifEven func n = if even n
                then func n
                else n

getIfEven func = (\n -> ifEven func n)
ifEvenInc n = getIfEven (\x -> x + 1) n
ifEvenDouble n = getIfEven (\x -> x * 2) n
ifEvenSquare n = getIfEven (\x -> x ^ 2) n

urlBuilder url apiKey resource id = url ++ "/" ++ resource ++ "/" ++ id ++ "?token=" ++ apiKey
bookIdBuiler id = urlBuilder "http://example.com" "1337hAsk3ll" "book" id

subtract2 = flip (-) 2