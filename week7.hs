import System.IO
import Data.List.Split (splitOn)
import Data.Char (isDigit)

-- Part 1
requestName :: IO String
requestName = do
    putStrLn "Enter Your Name"
    name <- getLine
    pure name

printName :: String -> IO ()
printName x = do
    putStrLn ("Hello " ++ x)

convertMeasure :: IO ()
convertMeasure = do
    putStrLn "Enter Centimetres: "
    input <- getLine
    let cm = read input :: Double
    let inch = cm / 2.54 :: Double
    putStrLn (show cm ++ " Centimetres = " ++ show inch ++ " Inches")

-- Part 2
printMenu :: IO ()
printMenu = do
    putStrLn "1) Push a number on the stack \n2) Add the top two numbers on the stack. \n3) Print all the values on the stack. \n4) Exit"

getMenuInput :: [Int] -> IO ()
getMenuInput acc = do
    printMenu
    putStrLn "Select Option: "
    input <- getLine
    let choice = read input :: Int
    handle choice acc

    where
        handle choice acc
            | choice == 1 = do
                putStrLn "Enter Num: "
                input <- getLine
                let val = read input :: Int
                getMenuInput (val : acc)
            | choice == 2 = do
                if length acc < 2 then getMenuInput acc else do
                    let a = head acc
                    let b = head (tail acc)
                    let restStack = drop 2 acc
                    getMenuInput ((a+b) : restStack)
            | choice == 3 = do
                putStrLn ("Current Stack: " ++ show acc)
                getMenuInput acc
            | choice == 4 = putStrLn "Exiting calculator..."
            | otherwise = do
                putStrLn "Invalid Input"
                getMenuInput acc

-- Part 3
data Movie = Movie {
    name :: String,
    year :: Int,
    actors :: [String]
    } deriving (Show)

parseTitleAndYear :: String -> (String, Int)
parseTitleAndYear rawTitle =
    let titlePart = takeWhile (/= '(') rawTitle
        yearPart  = filter isDigit rawTitle
        parsedYear = if null yearPart then 0 else read yearPart :: Int
    in (titlePart, parsedYear)

processLine :: Handle -> [Movie] -> IO [Movie]
processLine handle movies = do
    isEnd <- hIsEOF handle
    if isEnd
        then return movies
        else do
            currLine <- hGetLine handle
            let items = splitOn "/" currLine

            if null items || head items == ""
                then processLine handle movies
                else do
                    let (movieName, movieYear) = parseTitleAndYear (head items)
                    let movieActors = tail items

                    let newMovie = Movie {
                        name   = movieName,
                        year   = movieYear,
                        actors = movieActors
                    }                    }


                    processLine handle (movies ++ [newMovie])

readMovies :: String -> IO [Movie]
readMovies fileName = do
    handle <- openFile fileName ReadMode
    moviesList <- processLine handle []
    hClose handle
    return moviesList

main :: IO ()
main = do
    -- Testing Part 2 by default
    getMenuInput []
    parsedMovies <- readMovies "movies.txt"
    print parsedMovies