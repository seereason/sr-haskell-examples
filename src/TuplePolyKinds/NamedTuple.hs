{-# LANGUAGE GADTs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

-- | This module provides a way to name the fields in a regular
-- Haskell tuple and then look them up later, statically.

module Main where

import Data.String
import Language.Haskell.TH
import Data.Proxy
import GHC.TypeLits
import GHC.OverloadedLabels

-- | The syntax and the type of a field assignment.
data l := t = KnownSymbol l => Proxy l := t

-- Simple show instance for a field.
instance (Show t) => Show (l := t) where
  show (l := t) = symbolVal l ++ " := " ++ show t

-- | Means to search for a field within a tuple.
-- We could add `set` to this, or just have a `lens` method
-- which generates a lens for that field.
class Has (l :: Symbol) r a | l r -> a where
  get :: r -> a

-- Instances which we could easily generate with TH.
instance Has l (l := a) a where get (_ := a) = a
instance Has l ((l := a), u0) a where get ((_ := a),_) = a
instance Has l (u0, (l := a)) a where get (_,(_ := a)) = a
instance Has l ((l := a), u0, u1) a where get ((_ := a),_,_) = a
instance Has l (u0, (l := a), u1) a where get (_,(_ := a),_) = a
instance Has l (u0, u1, (l := a)) a where get (_,_,(_ := a)) = a

-- Provide convenient syntax: $("foo") for Proxy :: Proxy "foo".
instance IsString (Q Exp) where
  fromString str = [|Proxy :: Proxy $(litT (return (StrTyLit str)))|]

instance l ~ l' => IsLabel (l :: Symbol) (Proxy l') where
  fromLabel  = Proxy

instance Has l r a => IsLabel (l :: Symbol) (r -> a) where
  fromLabel = get @l

----------------------------------------------------------------------------------------------------

type User = ( "login" := String, "id" := Integer )

user :: User
user = ( #login := "themoritz", #id := 3522732 )

mentioned :: ( "url" := String, "title" := String, "user" := User )
mentioned = ( #url := "https://api.github.com/repos/commercialhaskell/intero/issues/64"
            , #title := "Support GHCJS"
            , #user := user
            )

main :: IO ()
main = do
  print $ #url mentioned           -- "https://api.github.com/repos/commercialhaskell/intero/issues/64"
  print $ #login (#user mentioned) -- "themoritz"
  print $ (#id . #user) mentioned  -- 3522732
