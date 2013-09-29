module Main where

import Control.Exception (bracket)
import Data.Functor
import Data.List
import System.IO
import System.IO.Error


-- catches or re-raises the exception.
catchCond :: [(IOError -> Bool, IOError -> IO a)] -> IOError -> IO a
catchCond cases e = case find (($ e) . fst) cases of
                      Just (_, catch) -> catch e
                      Nothing         -> ioError e

catchWhen :: (IOError -> Bool) -> (IOError -> IO a) -> IOError -> IO a
catchWhen p catch = catchCond [(p, catch)]

-- only catch exceptions caused by the openFile
-- (as opposed to the entire body)
tryWithFile :: (IOError -> IO a)
            -> FilePath -> IOMode -> (Handle -> IO a) -> IO a
tryWithFile catch f m body = do
    r <- tryIOError $ openFile f m
    case r of
      Left e  -> catch e
      Right h -> body h


withSubmakefile :: (Handle -> IO ()) -> IO ()
withSubmakefile = tryWithFile catch "submakefile" ReadMode
  where
    catch = catchWhen isDoesNotExistError $ \_ ->
              error "no submakefile found."

main = withSubmakefile $ \f -> do
         return ()
