{-# language PolyKinds #-}

{- I remember that there is a way to use PolyKinds to have one method of a class to handle all tuples.  Am I dreaming? -}
{- As is, this doesn't make sense. -}

class Foo t where
  foo :: (Typeable a, Typeble b) => (a,b) -> [TypeRep]

  
