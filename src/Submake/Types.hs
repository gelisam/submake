module Submake.Types where


data Recipe = Recipe { sourceFile :: String
                     , targetFile :: String
                     }
  deriving (Eq, Show)
