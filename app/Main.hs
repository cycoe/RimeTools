module Main (main) where

import System.IO (readFile)
import Options.Applicative
import Config (Config(..), configP)
import RimeTable (parseRimeTable)

main :: IO ()
main = do
  let opts = info (configP <**> helper) (
        fullDesc
        <> progDesc "Convert rime table to fcitx one"
        <> header "RimeTools - tools for rime im")
  config <- execParser opts
  process config

process :: Config -> IO ()
process config = do
  ls <- fmap lines . readFile $ rimeTableFile config
  let rt = parseRimeTable ls
  print rt
