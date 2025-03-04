{-# language CPP #-}
{-# language GADTs #-}
{-# language StandaloneDeriving #-}
{-# language ScopedTypeVariables #-}
{-# language NoMonomorphismRestriction #-}
{-# language TypeApplications #-}

module ImportExportGADT where

import Control.Monad.Reader
import Control.Monad.Trans
import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.List.NonEmpty as NE (head)

data Term a where
  Lit :: a -> Term a
  Apply :: Term (a -> b) -> Term a -> Term b

eval :: r -> Term a -> a
eval _ (Lit a) = a
eval r (Apply f a) =
  let eval' :: forall a. Term a -> a
      eval' = eval r
      f' = eval' f
      a' = eval' a
  in f' a'

evalM :: Monad m => r -> Term a -> m a
evalM _ (Lit a) = return a
evalM r (Apply f a) = do
  let evalM' :: forall m a. Monad m => Term a -> m a
      evalM' = evalM r
  f' <- evalM' f
  a' <- evalM' a
  return (f' a')

data TermR r a where
  LitR :: a -> TermR r a
  ApplyR :: TermR r (r -> a -> b) -> TermR r a -> TermR r b


evalR :: forall m r a. MonadReader r m => TermR r a -> m a
evalR (LitR a) = return a
evalR (ApplyR f a) = do
  r <- ask
  f' <- evalR f
  a' <- evalR a
  return (f' r a')

testR flag = runReader (evalR (ApplyR (LitR f) (LitR a))) flag
  where f :: Bool -> Int -> String
        f b i = if b then show i else show (-i)
        a = 17
          
