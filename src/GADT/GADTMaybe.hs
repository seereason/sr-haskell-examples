{-# language GADTs, StandaloneDeriving, TypeApplications #-}

data F x y where
  MkF :: y -> F (Maybe z) y

g :: F a a -> a
g (MkF Nothing) = Nothing
yg (MkF (Just x)) = Just x

--g2 :: F a a -> a
--g2 (MkF Nothing :: F (Maybe z) (Maybe z)) = Nothing @z
