{-# language PolyKinds #-}
{-# language TypeFamilies #-}

{- I remember that there is a way to use PolyKinds to have one method of a class to handle all tuples.  Am I dreaming? -}
{- As is, this doesn't make sense. -}

import Data.Typeable

class Typeable a => Foo a where
  foo :: a -> [TypeRep]

  

type family Tup a where
  Tup a = [TypeRep]
