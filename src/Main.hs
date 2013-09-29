module Main where

import Control.Applicative
import System.IO
import System.IO.Error
import System.IO.Error.Extra


data Recipe = Recipe { sourceFile :: String
                     , targetFile :: String
                     }
  deriving (Eq, Show)

parseRecipe :: String -> Recipe
parseRecipe xs = Recipe s t where
  (t, xs') = break (== ':') xs
  s = dropWhile (`elem` ": ") xs'

parseSubmakefile :: String -> [Recipe]
parseSubmakefile = map parseRecipe . lines


cook :: Recipe -> IO ()
cook r = withFile (targetFile r) WriteMode $ \t ->
         withFile (sourceFile r) ReadMode $ \s ->
           hPutStr t =<< hGetContents s


withSubmakefile :: (Handle -> IO ()) -> IO ()
withSubmakefile = tryWithFile catch "submakefile" ReadMode
  where
    catch = catchWhen isDoesNotExistError $ \_ ->
              error "no submakefile found."

main = withSubmakefile $ \f -> do
         xs <- hGetContents f
         mapM_ cook $ parseSubmakefile xs
