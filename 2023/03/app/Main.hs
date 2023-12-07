module Main where
import System.Environment (getArgs)
import System.IO (openFile, IOMode(ReadMode), hGetContents)
import Data.List.Split (splitOn)
import Text.Regex (matchRegex)
import Text.Regex.TDFA 
import Text.Regex.TDFA.String

checkSym :: String -> [String]
checkSym input = getAllTextMatches $ input =~ "[0-9]+|[*]|[#]|[$]" :: [String]

-- [0-9]+|[*]|[#]|[$]
extractNumbers :: String -> [String]
extractNumbers input = getAllTextMatches $ input =~ "[0-9]+" :: [String]

isDot :: Char -> Bool
isDot char = char == '.' 

findDots :: [Char] -> [Bool]
findDots x = map isDot x  

prog :: String -> [[Bool]]
prog x = let lines = splitOn "\n" x
         in map findDots lines

main :: IO ()
main = do
    args <- getArgs
    file <- openFile (head args) ReadMode
    schematic <- hGetContents file
    print schematic 

    print $ prog schematic
