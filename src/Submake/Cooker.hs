module Submake.Cooker where

import Control.Monad
import Control.Monad.Extra
import Data.List
import System.IO
import System.Process
import Text.Printf

import Submake.Git
import Submake.Types


cook_command :: Cachefile -> Command -> Hash -> IO Hash
cook_command cachefile cmd input_hash = do
    case find (\c -> inputHash c == input_hash && command c == cmd) cachefile of
      Just c -> return (outputHash c)
      Nothing -> do
        input <- readHash input_hash
        output <- readProcess "bash" ["-c", cmd] input
        output_hash <- cacheString output
        let cacheData = printf "%s %s %s\n" input_hash output_hash cmd
        appendFile "submakefile.cache" cacheData
        return output_hash

cook_recipe :: Cachefile -> Recipe -> IO ()
cook_recipe c r = do
    input_hash <- cacheFile (sourceFile r)
    output_hash <- loopM (commands r) input_hash (cook_command c)
    output <- readHash output_hash
    writeFile (targetFile r) output

cook_submakefile :: Cachefile -> Submakefile -> IO ()
cook_submakefile = mapM_ . cook_recipe
