module Main where

import Control.Applicative
import GHC.IO.Encoding
import System.IO
import System.IO.Error
import System.IO.Extra

import Submake.Cooker
import Submake.Types
import Submake.Parser


readSubmakefile :: IO Submakefile
readSubmakefile = do
    r <- tryReadFile "submakefile"
    case r of
      Left e | isDoesNotExistError e -> error "no submakefile found."
      Left e | otherwise             -> ioError e
      Right xs                       -> return $ parseSubmakefile xs

readCachefile :: IO Cachefile
readCachefile = do
    r <- maybeReadFile "submakefile.cache"
    case r of
      Nothing -> return $ []
      Just xs -> return $ parseCachefile xs

main = do
    -- for all file handles to use binary. otherwise the user
    -- couldn't use image-manipulation tools such as "pngtopnm".
    setLocaleEncoding char8
    
    c <- readCachefile
    s <- readSubmakefile
    cook_submakefile c s
