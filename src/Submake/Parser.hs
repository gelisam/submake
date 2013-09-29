module Submake.Parser where

import Submake.Types


parseRecipe :: String -> Recipe
parseRecipe xs = Recipe s t where
  (t, xs') = break (== ':') xs
  s = dropWhile (`elem` ": ") xs'

parseSubmakefile :: String -> [Recipe]
parseSubmakefile = map parseRecipe . lines
