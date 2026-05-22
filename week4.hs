maybeDefault :: a -> Maybe a -> a
maybeDefault x Nothing = x
maybeDefault _ (Just x) = x
-- Maybes either Just or Nothing, so If nothing return first argument and if Just return Maybe

data Cmp = LESSER | EQUAL | GREATER
    deriving (Show)

compareOrder :: Ord a => a -> a -> Cmp
compareOrder x y
    | x > y     = GREATER
    | x == y     = EQUAL
    | otherwise = LESSER
-- Guards must have an otherwise statement as fallback

data College = COUNTY | BOWLAND | CARTMEL | FURNESS | FYLDE | GRADUATE | GRIZEDALE | LONSDALE | PENDLE
    deriving (Show)

data Colour = RGB Int Int Int
    deriving (Show)

makeColour :: Int -> Int -> Int -> Maybe Colour
makeColour r g b
    | valid r && valid g && valid b = Just (RGB r g b)
    | otherwise = Nothing
    where
    valid x = x >= 0 && x <= 255

data Person =
    Student String Int College Int String |
    Academic String Int String |
    Services String Int String |
    Contract String Float
    deriving (Show)


isStudent :: Person -> Bool
isStudent (Student _ _ _ _ _) = True
isStudent _ = False

personName :: Person -> String
personName (Student x _ _ _ _) = x
personName (Academic x _ _) = x
personName (Services x _ _) = x
personName (Contract x _) = x


colorForPerson :: Person -> Maybe Colour
colorForPerson (Student _ _ _ _ "Computer Science") = makeColour 255 0 0
colorForPerson (Student _ _ _ _ "Software Engineering") = makeColour 0 0 255
colorForPerson (Student _ _ _ _ "Cyber Security") = makeColour 0 255 0
colorForPerson (Student _ _ _ _ "Data Science") = makeColour 128 0 128
colorForPerson _ = makeColour 200 200 200

data Students = Students Int Int deriving (Show)
data Database = Database [Students] deriving (Show)

findScoreById :: Int -> [Students] -> Maybe Int
findScoreByID _ [] = Nothing
findScoreById x (Students id score : xs)
    | x == id = Just score
    | otherwise = findScoreById x xs

maybeFindScore :: Person -> [Students] -> Maybe Int
maybeFindScore (Student _ sid _ _ _) xs = findScoreById sid xs
maybeFindScore _ _ = Nothing


updateScore :: Int -> Int -> [Students] -> Maybe [Students]
updateScore _ _ [] = Nothing
updateScore sid newscore (Students id score : xs)
    | sid == id = Just (Students id newscore : xs)
    | otherwise =
        case updateScore sid newscore xs of
            Nothing -> Nothing
            Just remaining -> Just (Students id score : remaining)


data Peano = Z | S Peano
instance Show Peano where
    show n = show (toInt n)
        where
            toInt Z = 0
            toInt (S x) = 1 + toInt x

addPeano :: Peano -> Peano -> Peano
addPeano Z n = n -- If first num == 0 Result is the second number
addPeano (S m) n = S (addPeano m n) -- If first num has successor peel off 1 S and move it to result

main :: IO ()
main = do
    putStrLn "Hello World!"