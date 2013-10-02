module Submake.Types where


type Command = String
type Hash = String


data Recipe = Recipe { sourceFile :: FilePath
                     , targetFile :: FilePath
                     , commands :: [Command]
                     }
  deriving (Eq, Show)

type Submakefile = [Recipe]


data CachedCommand = CachedCommand { inputHash :: Hash
                                   , outputHash :: Hash
                                   , command :: Command
                                   }
  deriving (Eq, Show)

type Cachefile = [CachedCommand]
