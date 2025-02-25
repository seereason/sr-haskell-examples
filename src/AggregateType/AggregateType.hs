{-# language TypeFamilies #-}
{-# language PolyKinds #-}
{-# language DataKinds #-}
{-# language KindSignatures #-}
{-# language UndecidableInstances #-}

import GHC.Base (Type)
import Data.Proxy
import GHC.Generics            

type family Aggregate k :: [Type] where
  Aggregate (a,b) = Nub (Aggregate a :++ Aggregate b)


type family Nub (a :: [Type]) :: [Type] where
  Nub '[] = '[]
  Nub ('[a]) = '[a]
  Nub (a ': a ': ts) = Nub (a ':ts )
  Nub (a ': b ': ts) = a ': (Nub (b ': ts))

type family Sort (xs :: [k]) :: [k] where
            Sort '[]       = '[]
            Sort (x ': xs) = ((Sort (Filter FMin x xs)) :++ '[x]) :++ (Sort (Filter FMax x xs))


data Flag = FMin | FMax

type family Filter (f :: Flag) (p :: k) (xs :: [k]) :: [k] where
            Filter f p '[]       = '[]
            Filter FMin p (x ': xs) = If (Cmp x p == LT) (x ': (Filter FMin p xs)) (Filter FMin p xs)
            Filter FMax p (x ': xs) = If (Cmp x p == GT || Cmp x p == EQ) (x ': (Filter FMax p xs)) (Filter FMax p xs)


type family (:++) (x :: [k]) (y :: [k]) :: [k] where
  '[]       :++ xs = xs
  (x ': xs) :++ ys = x ': (xs :++ ys)

infixr 5 :++
