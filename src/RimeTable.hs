module RimeTable where

import Data.Maybe (catMaybes)
import Data.List.Split (splitOn)

data Code = Code
  { key :: String
  , chars :: String
  } deriving Show

type RimeTable = [Code]

parseRimeTable :: [String] -> RimeTable
parseRimeTable = catMaybes . map parseEach where
  parseEach :: String -> Maybe Code
  parseEach l = case splitOn "\t" l of
    [c, k, w, h] -> Just $ Code k c
    _ -> Nothing
