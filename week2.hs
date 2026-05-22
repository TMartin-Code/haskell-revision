-- Part 1
lasts :: [a] -> a
lasts xs = head (reverse xs)

inits :: Ord a => [a] -> [a]
inits xs = drop 1 (reverse xs)

-- Part 2
bools :: [Bool]
bools = [True, False, True]

nums :: [[Int]]
nums = [[1,2],[1,3],[1..10]]

add :: (Int, Int) -> Int
add (x, y) = x + y

copy :: a -> (a,a)
copy x = (x,x)

swaps :: (a, b) -> (b,a)
swaps (x,y) = (y,x)

-- Part 3
second :: [a] -> a
second xs = head (tail xs)

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

pair :: a -> b -> (a,b)
pair x y = (x,y)

double :: Num a => a -> a
double x = x*2

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)

-- Part 4

sumList :: [Int] -> Int
sumList xs = sum xs

productList :: [Int] -> Int
productList xs = product xs

averageList :: [Int] -> Double
averageList xs = fromIntegral (sum xs) / fromIntegral (length xs)

comparePair :: Ord a => (a,a) -> Int
comparePair (x,y) =
    if x > y then 1
    else if x < y then -1
    else 0

-- Part 5
avgMark :: [Int] -> Int
avgMark xs = (sum xs) `div` (length xs)

highestMark :: Ord a => [a] -> a
highestMark xs = maximum xs

lowestMark :: Ord a => [a] -> a
lowestMark xs = minimum xs

main :: IO ()
main = do
    let marks = [85, 92, 78, 64, 88]
    print marks
    print (avgMark marks)
    print (highestMark marks)
    print (lowestMark marks)
    putStrLn "Hello World!"
