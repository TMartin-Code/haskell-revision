-- Part 1
-- Finished Last labs code

-- Part 2
risingSubseqLength :: [Int] -> Int
risingSubseqLength [] = 0
risingSubseqLength xs = go xs minBound 0 0
  where
    -- Arguments: remaining list, previous number, current chain length, max chain length seen so far
    go [] _ currentMax overallMax = max currentMax overallMax
    go (x:xs) prev currentMax overallMax
        -- If it keeps increasing, grow the current chain
        | x > prev  = go xs x (currentMax + 1) overallMax

        -- If it drops, the chain snaps! Save our progress and reset current chain to 1 (starting with x)
        | otherwise = go xs x 1 (max currentMax overallMax)

main :: IO ()
main = do
    putStrLn "Hello World!"