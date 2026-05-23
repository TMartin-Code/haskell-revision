-- Part 1
factorial :: Integer -> Integer
factorial 0 = 1
factorial x = x * factorial (x - 1)

factorial' :: Integer -> Maybe Integer
factorial' x
    | x < 0 = Nothing
    | otherwise = Just (go x 1)
    where
        go 0 acc = acc
        go x acc = go (x-1) (x * acc)


fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib x = fib(x-1) + fib (x-2)

fib' :: Integer -> Integer
fib' x = go x 0 1
    where
        go 0 a _ = a
        go count a b = go (count - 1) b (a+b)

sums :: Integer -> Integer
sums 0 = 0
sums x = x + sums (x-1)

sums' :: Integer -> Integer
sums' x = go x 0
    where
        go 0 acc = acc
        go x acc = go (x-1) (acc+x)

-- Part 2
doubleList :: [Int] -> [Int]
doubleList = map (*2)

lengthList :: [String] -> [Int]
lengthList = map length


returnEven :: [Int] -> [Int]
returnEven = filter even

gteThree :: [String] -> [String]
gteThree xs = filter (\x -> (length x > 3)) xs


squareOdd :: [Int] -> [Int]
squareOdd = map (^2) . filter odd

doubleEven :: [Int] -> [Int]
doubleEven = filter even . map (*2)


all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' f (x:xs) = f x && all' f xs

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = True
any' f (x:xs) = f x || any' f xs

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (x:xs)
    | f x = x : takeWhile' f xs
    | otherwise = []

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (x:xs)
    | f x = dropWhile' f xs
    | otherwise = x:xs

sum' :: Num a => [a] -> a
sum' = foldr (+) 0

flatten :: [[a]] -> [a]
flatten = foldr (++) []

allr :: (a -> Bool) -> [a] -> Bool
allr f xs = foldr (\x acc -> f x && acc) True xs

anyr :: (a -> Bool) -> [a] -> Bool
anyr f xs = foldr (\x acc -> f x || acc) True xs

takeWhiler :: (a -> Bool) -> [a] -> [a]
takeWhiler f xs = foldr (\x acc -> if f x then x : acc else []) [] xs

exists' :: Eq a => a -> [a] -> Bool
exists' i xs = foldr (\x acc -> i == x || acc) False xs


countStartingLetters :: [String] -> [(Char, Int)]
countStartingLetters words = foldr updatePairs [] words
  where
    -- This helper updates our accumulator list
    updatePairs [] acc = acc  -- Safely skip empty strings if any exist
    updatePairs (c:_) acc = incrementOrAdd c acc -- Passes first letter into incrementOrAdd

    -- If the letter matches, increment it. Otherwise, keep looking.
    incrementOrAdd c [] = [(c, 1)]
    incrementOrAdd c ((letter, count) : xs)
      | c == letter = (letter, count + 1) : xs
      | otherwise   = (letter, count) : incrementOrAdd c xs

main :: IO ()
main = do
    putStrLn "Hello World!"