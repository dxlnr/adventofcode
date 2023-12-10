module Main where
import System.Environment (getArgs)
import System.IO (openFile, IOMode(ReadMode), hGetContents)
import Data.List.Split (splitOn)
import Text.Regex (matchRegex, mkRegex, Regex, matchRegexAll)
import Data.Maybe (listToMaybe, catMaybes)
import Text.Read (readMaybe)

escapeRegex :: String -> String
escapeRegex = concatMap escapeChar
  where
    escapeChar c
      | c `elem` "\\+*?[^]$(){}=!<>|:-" = ['\\', c]
      | otherwise = [c]

findSubstrIdx :: String -> String -> (Int, Int)
findSubstrIdx substr str = case matchRegexAll (mkRegex substr) str of
    Nothing -> (-1, -1)
    Just (pre, match, _, _) -> (length pre, length pre + length match - 1)

findSymIdx :: String -> String -> Int
findSymIdx substr str = case matchRegexAll (mkRegex (escapeRegex substr)) str of
    Nothing -> -1
    Just (pre, _, _, _) -> length pre

matchAll :: Regex -> String -> [(String, (Int, Int))]
matchAll regex s = go s
  where
    go str = case matchRegexAll regex str of
        Nothing -> []
        Just (pre, match, rest, _) -> (match, findSubstrIdx match s) : go rest

matchAllSym :: String -> String -> [Int]
matchAllSym pattern input = go input
  where
    regex = mkRegex pattern
    go s = case matchRegexAll regex s of
        Nothing -> []
        Just (_, match, rest, _) -> findSymIdx match input : go rest

findAllNumbersWithIndices :: String -> [(String, (Int, Int))]
findAllNumbersWithIndices input = matchAll (mkRegex "[0-9]+") input

findAllSymWithIndices :: String -> [Int]
findAllSymWithIndices input = matchAllSym "[=*#/$&@%-+]" input

prog :: String -> [[(String, (Int, Int))]]
prog x = let lines = splitOn "\n" x
         in map findAllNumbersWithIndices lines

progSym :: String -> [[Int]]
progSym x = let lines = splitOn "\n" x
         in map findAllSymWithIndices lines

concatNeighbors :: [[Int]] -> [[Int]]
concatNeighbors lst = concatNeighborsHelper Nothing lst
  where
    concatNeighborsHelper _ [] = []
    concatNeighborsHelper prev (x:xs) =
      let next = listToMaybe xs
      in concatMaybeLists [prev, Just x, next] : concatNeighborsHelper (Just x) xs

    concatMaybeLists :: [Maybe [Int]] -> [Int]
    concatMaybeLists = concat . catMaybes

compareElements :: (a -> b -> [String]) -> [a] -> [b] -> [[String]]
compareElements f l1 l2 = zipWith f l1 l2

withinRange :: [(String, (Int, Int))] -> [Int] -> [String]
withinRange ranges ints = map (rangeString . findRange) ints
  where
    findRange i = filter (\(_, (low, high)) -> i >= low - 1 && i <= high + 1) ranges
    rangeString ((s, _):_) = s
    rangeString _ = ""

filterNotEmpty :: [[String]] -> [String]
filterNotEmpty = concat . (map (filter (/= "")))

convertStringToInt :: [String] -> [Int]
convertStringToInt str = map (\x -> read x :: Int) str

sumAll :: [Int] -> Int
sumAll [] = 0
sumAll (x:xs) = x + sumAll xs

main :: IO ()
main = do
    args <- getArgs
    file <- openFile (head args) ReadMode
    schematic <- hGetContents file

    let ns = prog schematic
    let syms = progSym schematic
    let symnn = concatNeighbors syms

    let res = sum (convertStringToInt (filterNotEmpty $ compareElements withinRange ns symnn))
    print res
