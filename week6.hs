-- Part 1
hundredSquares :: Int
hundredSquares = sum [ x*x | x <- [1..100]]

grid :: Int -> Int -> [(Int,Int)]
grid x y = [(a,b) | a <- [0..x], b <- [0..y]]

square :: Int -> [(Int,Int)]
square x = [(a,b) | a <- [0..(x-1)], b <- [0..(x-1)], a /= b] -- Adds squares to grid as long as first element isnt equal to the second

find :: Eq a => a -> [(a, b)] -> [b]
find i xs = [x | (k, x) <- xs, k == i] -- Retrieves each key value pair and only returns the value if they key and searched key match

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f x]


replicate' :: Int -> a -> [a]
replicate' count val = [val | _ <- [1.. count]]

pyths :: Int -> [(Int, Int, Int)]
pyths val = [(x, y, z) | x <- [1.. 10], y <- [1.. 10], z <- [1.. 10], (x*x) + (y*y) == (z*z)]


lowers :: String -> Int
lowers xs = length [x | x <- xs, x >= 'a' && x <= 'z']

perfects :: Int -> [Int]
perfects i = [x | x <- [1.. i], sum (factors x) == x]

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0, x /= n]

concatedGen' :: [(Int, Int)]
concatedGen' = concat [[(x,y)| y <- [3,4]] | x <- [1,2]] -- Like Nested For Loop, x runs first, so x = 1 [(1,3),(1,4)] x = 2 [(2,3),(2,4)],
                                                         -- Its then concated together to combine the 2 sublists

positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x',i) <- zip xs [0..], x == x'] -- Uses zip to find indexs of the matching values

positions' :: Eq a => a -> [a] -> [Int]
positions' x xs = find x (zip xs [0..])

-- Part 2
sumEvenSquares :: [Int] -> Int
sumEvenSquares = foldl (\acc x -> if even x then acc + (x*x) else acc) 0

takeWhilel :: (a -> Bool) -> [a] -> [a]
--takeWhiler f xs = foldr (\x acc -> if f x then x : acc else []) [] xs
takeWhilel f xs = foldl (\acc x -> if f x then acc ++ [x] else acc) [] xs


main :: IO ()
main = do
    putStrLn "Hello World!"