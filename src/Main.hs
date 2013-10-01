module Main where

import Control.Applicative
import GHC.IO.Encoding
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

main = do
    -- for all file handles to use binary. otherwise the user
    -- couldn't use image-manipulation tools such as "pngtopnm".
    setLocaleEncoding char8
    
    withSubmakefile $ \f -> do
      s <- parseSubmakefile <$> hGetContents f
      cook_submakefile s
