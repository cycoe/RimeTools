module Main (main) where

import Data.List (intercalate)
import Options.Applicative
import Config (Config(..), configP)
import CodeTable (TableFormat(..), RimeTable(..), FcitxTable(..))

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
  let ct = unformat $ RimeTable ls
      FcitxTable ft = format ct
  writeFile (outputFile config) $ intercalate "\n" ft
