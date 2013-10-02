module Submake.Git where

import System.Process
import System.Process.Extra

import Submake.Types


hashFile :: FilePath -> IO Hash
hashFile filename = readProcess1 "git" ["hash-object", filename] ""

cacheFile :: FilePath -> IO Hash
cacheFile filename = readProcess1 "git" ["hash-object", "-w", filename] ""


hashString :: String -> IO Hash
hashString = readProcess1 "git" ["hash-object", "--stdin"]

cacheString :: String -> IO Hash
cacheString = readProcess1 "git" ["hash-object", "-w", "--stdin"]


hasHash :: Hash -> IO Bool
hasHash sha1 = do
    xs <- readProcess1 "git" ["cat-file", "-t", sha1] ""
    return (xs == "blob")

readHash :: Hash -> IO String
readHash sha1 = readProcess "git" ["cat-file", "-p", sha1] ""
