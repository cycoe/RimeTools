module CodeTable where

import Data.Maybe (catMaybes)
import Text.Read (readMaybe)
import Data.List.Split (splitOn)

data Code = Code
  { key :: String
  , chars :: String
  , weight :: Maybe Int
  , hint :: Maybe String
  } deriving Show

type CodeTable = [Code]

class TableFormat t where
  format :: CodeTable -> t
  unformat :: t -> CodeTable

newtype RimeTable = RimeTable [String]
newtype FcitxTable = FcitxTable [String]

instance TableFormat RimeTable where
  format = undefined
  unformat = parseRimeTable

instance TableFormat FcitxTable where
  format = formatFcitxTable
  unformat = undefined

parseRimeTable :: RimeTable -> CodeTable
parseRimeTable (RimeTable rt) = catMaybes . map parseEach $ rt where
  parseEach :: String -> Maybe Code
  parseEach l = case splitOn "\t" l of
    [c, k] -> Just $ Code k c Nothing Nothing
    [c, k, w] -> Just $ Code k c (readMaybe w) Nothing
    [c, k, w, h] -> Just $ Code k c (readMaybe w) (Just h)
    _ -> Nothing

formatFcitxTable :: CodeTable -> FcitxTable
formatFcitxTable = FcitxTable . map formatEach where
  formatEach :: Code -> String
  formatEach (Code k c _ _) = k <> "\t" <> c
