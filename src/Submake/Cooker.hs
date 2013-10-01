module Submake.Cooker where

import Control.Monad
import Control.Monad.Extra
import System.IO
import System.Process
import Text.Printf

import Submake.Git
import Submake.Types


cook_command :: Command -> String -> IO String
cook_command command input = do
    output <- readProcess "bash" ["-c", command] input
    input_hash  <- hashString input
    output_hash <- hashString output
    let cacheData = printf "%s %s %s\n" input_hash output_hash command
    appendFile "submakefile.cache" cacheData
    return output

cook_recipe :: Recipe -> IO ()
cook_recipe r = do
    input <- readFile (sourceFile r)
    output <- loopM (commands r) input cook_command
    writeFile (targetFile r) output

cook_submakefile :: Submakefile -> IO ()
cook_submakefile = mapM_ cook_recipe
