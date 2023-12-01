module Config where

import System.FilePath (FilePath)
import Options.Applicative

data Config = Config
  { rimeTableFile :: FilePath
  , rimeWordsFile :: FilePath
  , outputFile :: FilePath
  } deriving Show

configP :: Parser Config
configP = Config
  <$> strOption (long "rime-table"
                <> short 't'
                <> metavar "PATH"
                <> help "Rime table file path")
  <*> strOption (long "rime-words"
                <> short 'w'
                <> metavar "PATH"
                <> help "Rime words file path")
  <*> strOption (long "output"
                <> short 'o'
                <> metavar "PATH"
                <> help "Output path for fcitx table file")
