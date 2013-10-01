module Control.Monad.Extra where

import Control.Monad


-- loopM is to foldM what forM is to mapM.
loopM :: Monad m => [b] -> a -> (b -> a -> m a) -> m a
loopM xs y f = foldM (flip f) y xs
