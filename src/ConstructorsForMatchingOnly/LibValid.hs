{-# language GADTs #-}

module LibValid ( V(..), mkV, mkGuard) where

data V a where
  V :: Guard a -> a -> V a
  deriving Show

data Guard a = Guard String (a -> Bool)

instance Show a => Show (Guard a) where
  show (Guard nm _) = ("Guard " <> nm)


mkV :: Guard a -> a -> Maybe (V a)
mkV g@(Guard _ f) a = if f a then Just (V g a) else Nothing

mkGuard :: String -> (a -> Bool) -> Guard a
mkGuard = Guard

