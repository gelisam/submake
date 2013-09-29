module Main where

import Control.Applicative
import System.IO
import System.IO.Error
import System.IO.Error.Extra

import Submake.Cooker
import Submake.Types
import Submake.Parser


withSubmakefile :: (Handle -> IO ()) -> IO ()
withSubmakefile = tryWithFile catch "submakefile" ReadMode
  where
    catch = catchWhen isDoesNotExistError $ \_ ->
              error "no submakefile found."

main = withSubmakefile $ \f -> do
         xs <- hGetContents f
         mapM_ cook $ parseSubmakefile xs
