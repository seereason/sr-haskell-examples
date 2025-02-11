{-# language GADTs #-}

module Lib ( D(..),  mkD) where

data D a where
  D :: Guard -> a -> D a
  deriving Show

data Guard = Guard deriving Show

mkD :: a -> D a
mkD = D Guard
