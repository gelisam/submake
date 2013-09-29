module Main where

import System.IO
import System.IO.Error
import System.IO.Error.Extra


withSubmakefile :: (Handle -> IO ()) -> IO ()
withSubmakefile = tryWithFile catch "submakefile" ReadMode
  where
    catch = catchWhen isDoesNotExistError $ \_ ->
              error "no submakefile found."

main = withSubmakefile $ \f -> do
         return ()
