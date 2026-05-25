-------------------------------------------------------------------------------
-- Types --
-------------------------------------------------------------------------------
-- Int      Fixed-Precision Integer                 1, -5
-- Integer  Arbitrary-Precision Integer             12345678901234567890
-- Float    Single-Precision Floating-Point Number  3.14159
-- Double   Double-Precision Floating-Point Number  2.718281828459
-- Char     A Single Unicode Character              'a', 'A'
-- String   A List of Characters                    "Hello World"
-- Bool     Boolean Logic Values                    True, False

-------------------------------------------------------------------------------
-- Type Constraints -- (=>)
-------------------------------------------------------------------------------

-- Eq       Equalty             Checks (==) or (/=)
-- Ord      Ordering            Implements (<, <=, =>, >) If Inheriting Ord Must also inherit Eq
-- Show     String Conversion   Types whose values can be turned into printable String
-- Read     Parsing             Types whose values can be turned from String to Concrete Value
-- Integral                     Read Whole Numbers that support integer division (div, mod) implemented by Int/Integer
-- Fractional                   Numbers that support true fractional division, uses (/) implemented by Float/Double

-------------------------------------------------------------------------------
-- Functors / Applicatives / Monads --
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Functors:
-------------------------------------------------------------------------------

-- Context that can be mapped over
-- Applies function to value inside a container, without affecting structure
-- Uses fmap :: (a -> b) -> f a -> f b

class Functor f where
    fmap :: (a -> b) -> f a -> f b

-- A normal function that expects a regular Int
plusThree :: Int -> Int
plusThree x = x + 3

-- Using fmap to reach inside the Maybe box
functorExample1 :: Maybe Int
functorExample1 = fmap plusThree (Just 2)  -- Result: Just 5

-- If the box is empty (Nothing), fmap safely does nothing
functorExample2 :: Maybe Int
functorExample2 = fmap plusThree Nothing   -- Result: Nothing

-- Using the <$> operator alias (looks like normal function application)
functorExample3 :: Maybe Int
functorExample3 = plusThree <$> Just 10    -- Result: Just 13

-------------------------------------------------------------------------------
-- Applicatives:
-------------------------------------------------------------------------------

-- Applying a function in a container to a value in a container
-- implements <*> (Apply) extracts function from first box and value from second, applies them and places result in new box
-- Also provides pure, takes normal value and wraps it in default box

class Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

-- We have a function that takes two arguments
add :: Int -> Int -> Int
add x y = x + y

-- We want to apply it to two separate Maybe boxes: Just 3 and Just 4
applicativeExample1 :: Maybe Int
applicativeExample1 = pure add <*> Just 3 <*> Just 4  -- Result: Just 7

-- Alternative syntax using Functor (<$>) for the first step:
applicativeExample2 :: Maybe Int
applicativeExample2 = add <$> Just 3 <*> Just 4       -- Result: Just 7

-- If ANY of the boxes are Nothing, the whole thing safely collapses to Nothing
applicativeExample3 :: Maybe Int
applicativeExample3 = add <$> Just 3 <*> Nothing      -- Result: Nothing

-------------------------------------------------------------------------------
-- Monad:
-------------------------------------------------------------------------------

-- Each step of the computation decides what happens based off of the previous steps output
-- Uses bind operator (>>=), takes a boxed value, unwraps and feeds it to a function that returns a box, returns resulting box without nesting it

class Monad m where
    (>>=) :: m a -> (a -> m b) -> m b
    (>>=) :: m a -> m b -> m b
    pure :: a -> m a

-- A function that takes a normal Int but returns a Maybe box
halveEven :: Int -> Maybe Int
halveEven n
    | even n    = Just (n `div` 2)
    | otherwise = Nothing

-- Using Monadic Bind (>>=) to chain operations
monadExample1 :: Maybe Int
monadExample1 = Just 20 >>= halveEven              -- Result: Just 10

-- We can sequentially chain them. If any step returns Nothing,
-- the chain short-circuits safely.
monadExample2 :: Maybe Int
monadExample2 = Just 20 >>= halveEven >>= halveEven -- Result: Just 5 (20 -> 10 -> 5)

monadExample3 :: Maybe Int
monadExample3 = Just 20 >>= halveEven >>= halveEven >>= halveEven
-- Result: Nothing (because 5 is odd, the 3rd step returns Nothing)
