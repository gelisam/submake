module System.IO.Extra where

import Control.Exception.Base
import Data.Functor
import System.IO
import System.IO.Error


tryReadFile :: FilePath -> IO (Either IOError String)
tryReadFile filename = tryIOError $ readFile filename

maybeReadFile :: FilePath -> IO (Maybe String)
maybeReadFile filename = do
    r <- tryIOError $ openFile filename ReadMode
    case r of
      Left _  -> return Nothing
      Right h -> Just <$> hGetContents h
