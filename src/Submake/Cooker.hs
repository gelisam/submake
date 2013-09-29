module Submake.Cooker where

import System.IO

import Submake.Types


cook :: Recipe -> IO ()
cook r = withFile (targetFile r) WriteMode $ \t ->
         withFile (sourceFile r) ReadMode $ \s ->
           hPutStr t =<< hGetContents s
