{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Use sum" #-}

module HaskellCheatSheet where


-------------------------------------------------------------------------------
-- 1. TERMINOLOGY & PHILOSOPHY
-------------------------------------------------------------------------------
{-
   Haskell is a Purely Functional language:
   - Pure: Functions have no side effects. Given the same inputs, they always
     return the same output (Referential Transparency).
   - Immutable: Variables cannot change their values once bound.
   - Lazy Evaluation: Expressions are not evaluated until their results are
     actually needed.
   - Statically Typed: Every expression has a type known at compile-time.
   - Type Inference: The compiler (GHC) can automatically deduce types.
-}


-------------------------------------------------------------------------------
-- 2. BASIC SYNTAX & CHARACTERISTICS
-------------------------------------------------------------------------------

-- Inline comments use two dashes.
{- Multi-line comments
   can look like this. -}

-- Variable binding (Variables cannot change value)
x :: Int
x = 5

-- Functions are applied using whitespace, not parentheses or commas
-- Example: max 4 5  (evaluates to 5)


-------------------------------------------------------------------------------
-- 3. CHIEF TYPE SIGNATURES & PRIMITIVES
-------------------------------------------------------------------------------

aChar   :: Char
aChar   = 'A'

aString :: String
aString = "Hello, Haskell!"  -- Strings are just lists of characters ([Char])

anInt   :: Int
anInt   = -42                -- Fixed-precision machine integer

anInteger :: Integer
anInteger = 123456789012345678901234567890 -- Arbitrary-precision integer

aFloat  :: Float
aFloat  = 3.14159 -- 32-Bit Float Value

aDouble :: Double
aDouble = 2.718281828459045 -- 64-Bit Float Value

aBool   :: Bool
aBool   = True               -- Values can be True or False


-------------------------------------------------------------------------------
-- 4. BASIC FUNCTIONS & OPERATORS
-------------------------------------------------------------------------------

-- Simple function declaration with explicit type signature
addTwo :: Int -> Int -> Int
addTwo a b = a + b

-- Functions are first-class: they can be passed as arguments or returned
applyTwice :: (a -> a) -> a -> a
applyTwice f val = f (f val)

-- Function composition using the dot (.) operator: (f . g) x == f (g x)
addOneAndDouble :: Int -> Int
addOneAndDouble = (*2) . (+1)  -- Uses "sections" / partial application

-- The application operator ($) replaces parentheses by evaluating the right side first
-- regular:    sqrt (floatFromInt (max 4 9))
-- with ($):   sqrt $ floatFromInt $ max 4 9


-------------------------------------------------------------------------------
-- 5. CONDITIONS & CONTROL FLOW
-------------------------------------------------------------------------------

-- If-Else statements MUST always have an 'else' block because they are expressions
checkSize :: Int -> String
checkSize n = if n > 100
              then "Large"
              else "Small"

-- Guard Syntax (cleaner alternative to nested if-else)
bmiTell :: Double -> String
bmiTell bmi
    | bmi <= 18.5 = "Underweight"
    | bmi <= 25.0 = "Normal weight"
    | bmi <= 30.0 = "Overweight"
    | otherwise   = "Obese"

-- Case Expressions (Pattern matching anywhere)
describeList :: [a] -> String
describeList list = "The list is " ++ case list of
    []  -> "empty."
    [_] -> "a singleton list."
    _   -> "a longer list."


-------------------------------------------------------------------------------
-- 6. DATA STRUCTURES: LISTS & TUPLES
-------------------------------------------------------------------------------

-- Lists: Homogeneous (all elements must be the same type)
numbers :: [Int]
numbers = [1, 2, 3, 4, 5]

-- Constructing lists with cons (:) and empty list []
moreNumbers :: [Int]
moreNumbers = 0 : numbers  -- [0, 1, 2, 3, 4, 5]

-- List Concatenation (++)
combinedList :: [Int]
combinedList = [1, 2] ++ [3, 4]

-- List Comprehensions
evensUpToTen :: [Int]
evensUpToTen = [x | x <- [1..10], x `mod` 2 == 0]

-- Tuples: Heterogeneous (can mix types, fixed size)
userProfile :: (String, Int, Bool)
userProfile = ("Alice", 28, True)

-- Accessing pairs (2-tuples only)
name :: String
name = fst ("Bob", 32)
age :: Int
age = snd ("Bob", 32)


-------------------------------------------------------------------------------
-- 7. PATTERN MATCHING & RECURSION
-------------------------------------------------------------------------------

-- Pattern matching splits functionality based on structural values
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Pattern matching on lists: (x:xs) splits the head (x) from the tail (xs)
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs


-------------------------------------------------------------------------------
-- 8. HIGHER-ORDER FUNCTIONS
-------------------------------------------------------------------------------

-- Map: transforms every element in a list
squaredNumbers :: [Int]
squaredNumbers = map (\n -> n * n) [1..5]  -- Uses a lambda syntax (\\input -> output)

-- Filter: retains items matching a predicate
onlyOdds :: [Int]
onlyOdds = filter odd [1..10]

-- Foldl / Foldr: reduces a list to a single value using an accumulator
sumUsingFold :: [Int] -> Int
sumUsingFold = foldl (+) 0


-------------------------------------------------------------------------------
-- 9. CUSTOM DATA TYPES & TYPECLASSES
-------------------------------------------------------------------------------

-- Algebraic Data Type (ADT) with Record Syntax
data Employee = Employee
  { empName :: String
  , empRole :: String
  , empId   :: Int
  } deriving (Show, Eq) -- Deriving automatically implements standard functionality

-- Enumeration Type
data TrafficLight = Red | Yellow | Green

-- Creating a Custom Typeclass (analogous to Interfaces in other languages)
class Describable a where
    describe :: a -> String

-- Implementing a Typeclass Instance
instance Describable TrafficLight where
    describe Red    = "Stop!"
    describe Yellow = "Caution!"
    describe Green  = "Go!"


-------------------------------------------------------------------------------
-- 10. FUNCTORS, APPLICATIVES, & MONADS
-------------------------------------------------------------------------------

{-
  - Functor: A context that can be mapped over. Implements `fmap`.
  - Applicative: A context containing values OR functions that can be applied to each other. Implements `pure` and `<*>`.
  - Monad: A context that allows sequential chaining of actions where subsequent actions depend on prior results. Implements `return` and `>>=` (bind).
-}

-- Maybe Monad example for safe computation
safeDivide :: Double -> Double -> Maybe Double
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

-- Chaining with Monadic Bind (>>=)
-- If any stage returns Nothing, the whole chain becomes Nothing safely.
monadicCalculation :: Maybe Double
monadicCalculation = Just 10.0 >>= \a -> safeDivide a 2.0 >>= \b -> safeDivide b 0.0

-- "do" notation provides clean syntactic sugar for Monadic actions
doNotationExample :: Maybe Double
doNotationExample = do
    a <- Just 10.0
    b <- safeDivide a 2.0
    safeDivide b 2.0  -- Returns Just 1.25


-------------------------------------------------------------------------------
-- 11. INPUT/OUTPUT (I/O)
-------------------------------------------------------------------------------

-- 'main' is the executable entrypoint. IO actions are inherently pure because
-- they describe an execution blueprint that GHC safely processes at runtime.
main :: IO ()
main = do
    putStrLn "Welcome to the Haskell Cheat Sheet!"
    putStrLn "What is your name?"
    inputName <- getLine
    putStrLn $ "Hello, " ++ inputName ++ "! Happy hacking."
