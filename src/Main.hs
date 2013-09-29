module Main where

import System.IO


main = withFile "out" WriteMode $ flip hPutStrLn "ok"
