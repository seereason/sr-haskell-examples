{-# language GADTs, StandaloneDeriving #-}

data SomeShow where
  SomeShow :: Show a => a -> SomeShow


deriving instance Show SomeShow -- where
  -- show (SomeShow a) = show a


p = (SomeShow 1,  SomeShow "foo")
