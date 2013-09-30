module Submake.Cooker where

import Control.Monad
import System.IO
import System.Process

import Submake.Types


shell_io :: String -> Handle -> IO Handle
shell_io cmd input = do
    (Nothing, Just output, Nothing, _) <- createProcess info'
    hSetBinaryMode output True
    return output
  where
    info = shell cmd
    info' = info { std_in = UseHandle input
                 , std_out = CreatePipe
                 , close_fds = True
                 }

cook :: Recipe -> IO ()
cook r = withFile (targetFile r) WriteMode $ \t ->
         withFile (sourceFile r) ReadMode $ \s -> do
           hSetBinaryMode t True
           hSetBinaryMode s True
           output <- foldM (flip shell_io) s (commands r)
           hPutStr t =<< hGetContents output
