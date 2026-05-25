
-- Types --
-- Int      Fixed-Precision Integer                 1, -5
-- Integer  Arbitrary-Precision Integer             12345678901234567890
-- Float    Single-Precision Floating-Point Number  3.14159
-- Double   Double-Precision Floating-Point Number  2.718281828459
-- Char     A Single Unicode Character              'a', 'A'
-- String   A List of Characters                    "Hello World"
-- Bool     Boolean Logic Values                    True, False

-- Type Constraints -- (=>)

-- Eq       Equalty             Checks (==) or (/=)
-- Ord      Ordering            Implements (<, <=, =>, >) If Inheriting Ord Must also inherit Eq
-- Show     String Conversion   Types whose values can be turned into printable String
-- Read     Parsing             Types whose values can be turned from String to Concrete Value
-- Integral                     Read Whole Numbers that support integer division (div, mod) implemented by Int/Integer
-- Fractional                   Numbers that support true fractional division, uses (/) implemented by Float/Double