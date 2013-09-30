module Submake.Parser where

import Data.Char

import Submake.Types


parseRecipe :: String -> [String] -> Recipe
parseRecipe xs = Recipe s t where
  (t, xs') = break (== ':') xs
  s = dropWhile (`elem` ": ") xs'

parseSubmakefile :: String -> [Recipe]
parseSubmakefile = parseRecipes . filter (not . null) . lines
  where
    parseRecipes [] = []
    parseRecipes (x:xs) = parseRecipe x (map unindent xs')
                        : parseRecipes xs''
      where
        (xs', xs'') = break (not . indented) xs
        indented "" = False
        indented (x:xs) = isSpace x
        unindent = dropWhile isSpace
