module System.Process.Extra where

import Data.Functor
import Data.List.Extra
import System.Process


-- also strips the trailing newline
readProcess1 :: FilePath -> [String] -> String -> IO String
readProcess1 x xs i = safeHead "" . lines <$> readProcess x xs i
