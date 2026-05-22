-- Part 1
isEven :: Int -> Bool
isEven x
    | x `mod` 2 == 0 = True
    | otherwise = False

splitAtN :: [a] -> Int -> ([a],[a])
splitAtN xs n = (take (n-1) xs, drop (n-1) xs)

reciprocal :: Int -> Double
reciprocal x = 1 / fromIntegral x

-- Part 2
gradeStudent1 :: Int -> String
gradeStudent1 x =
    if x >= 90 && x <= 100 then "A"
    else if x >= 80 then "B"
    else if x >= 70 then "C"
    else if x >= 60 then "D"
    else "F"

gradeStudent2 :: Int -> String
gradeStudent2 x | x >= 90 && x <= 100 = "A"
    | x >= 80= "B"
    | x >= 70 = "C"
    | x >= 60 = "D"
    | otherwise = "F"

gradeStudent3 :: Int -> String
gradeStudent3 x = case x `div` 10 of
    10 -> "A"
    9 -> "A"
    8 -> "B"
    7 -> "C"
    6 -> "D"
    _ -> "F"

-- Part 3
multiply :: Num a => a -> a -> a -> a
multiply x y z = x * y * z

doubleAndMultiply :: Num a => a -> a -> a
doubleAndMultiply x y = multiply 2 x y

powerOf :: Int -> Int -> Int
powerOf x y = product (replicate y x)

square :: Int -> Int
square x = powerOf x 2

cube :: Int -> Int
cube x = powerOf x 3

fourthPower :: Int -> Int
fourthPower x = powerOf x 4

-- Part 4
-- Maybe
heads :: [a] -> Maybe a
heads [] = Nothing
heads (x:xs) = Just x

tails :: [a] -> Maybe [a]
tails [] = Nothing
tails (x:xs) = Just xs

inits :: [a] -> Maybe [a]
inits [] = Nothing
inits xs = Just (take (length xs - 1) xs)

lasts :: [a] -> Maybe a
lasts [] = Nothing
lasts xs = Just (head (reverse xs))

mins :: Ord a => [a] -> Maybe a
mins [] = Nothing
mins [x] = Just x
mins (x:xs) =
    case mins xs of
        Nothing -> Just x
        Just m  -> Just (min x m)

maxs :: Ord a => [a] -> Maybe a
maxs [] = Nothing
maxs [x] = Just x
maxs (x:xs) =
    case maxs xs of
        Nothing -> Just x
        Just m -> Just (max x m)

-- Either
heads' :: [a] -> Either String a
heads' [] = Left "Empty List"
heads' (x:xs) = Right x

tails' :: [a] -> Either String [a]
tails' [] = Left "Empty List"
tails' (x:xs) = Right xs

inits' :: [a] -> Either String [a]
inits' [] = Left "Empty List"
inits' xs = Right (take (length xs - 1) xs)

lasts' :: [a] -> Either String a
lasts' [] = Left "Empty List"
lasts' xs = Right (head (reverse xs))

mins' :: Ord a => [a] -> Either String a
mins' [] = Left "Empty List"
mins' [x] = Right x
mins' (x:xs) =
    case mins' xs of
        Left err -> Left err
        Right m -> Right (min x m)

maxs' :: Ord a => [a] -> Either String a
maxs' [] = Left "Empty List"
maxs' [x] = Right x
maxs' (x:xs) =
    case maxs' xs of
        Left err -> Left err
        Right m -> Right (max x m)
main :: IO ()
main = do
    putStrLn "Hello World!"