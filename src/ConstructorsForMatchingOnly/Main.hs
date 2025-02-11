{- the question posed in this page (https://discourse.haskell.org/t/how-to-expose-gadt-constructors-for-pattern-matching-but-not-creation/11333/2)
   is how to expose constructors for matching, but not creation.
   the questioner answered their own question, but I didn't find it convincing.
 -}


{-# language GADTs #-}

import Data.Maybe

import Lib (D(..), mkD)
import LibValid (V(..), mkV, mkGuard)

main = do
  testD
  testV

testD = do
  let ns = map mkD [1..3]
      pp (D _guard a) = "(D " <> show a <> ")"
  mapM_ print ns
  mapM_ (putStrLn . pp) ns

testV = do
  let ns :: [V Int]
      ns = mapMaybe (mkV g) [1..20]
      g = mkGuard "odd" odd
  print ns
