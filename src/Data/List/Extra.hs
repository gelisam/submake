module Data.List.Extra where


safeHead :: a -> [a] -> a
safeHead d [] = d
safeHead _ xs = head xs

safeTail :: [a] -> [a] -> [a]
safeTail d [] = d
safeTail _ xs = tail xs

safeLast :: a -> [a] -> a
safeLast d [] = d
safeLast _ xs = last xs
