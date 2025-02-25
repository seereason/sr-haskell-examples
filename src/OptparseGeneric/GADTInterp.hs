-- Example.hs

{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE GADTs #-}

import System.IO

{- I'm trying to use a GADT as a DSL, but I'm not sure what my goal is.
Examples are geared for interpreting term equations.

Okay, goal is to make is a DSL for the entire app, merge it with HaXL, acid state.

Composable interpreters.

-}


data C a where
  FileName :: Proxy a -> FilePath -> C a
  Handle :: Proxy a -> Handle -> C a
  Val :: Proxy a ->  C a

interp :: C a -> IO a
interp = \case
  File h -> hClose h
  Close h -> hClose h
  Open fp -> openFile fp ReadMode
