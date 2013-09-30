module Submake.Types where


data Recipe = Recipe { sourceFile :: String
                     , targetFile :: String
                     , commands :: [String]
                     }
  deriving (Eq, Show)
