DSF asks:
I think I don't understand haskell class default methods
how is the choice made between invoking a class default method and invoking an instance method?


There are several relevant Haskell features.

This sort of default method implementation is available in Haskell98:

\begin{code}
{-# language DefaultSignatures #-}

class Enum' a where
  enum' :: [a]
  enum' = []


data Foo = Foo deriving Show
instance Enum' Foo
  
data Bar = Bar deriving (Enum, Show)
instance Enum' Bar where
  enum' = enumFrom Bar 
  
\end{code}

\begin{verbatim}
*Main> enum' :: [Foo]
[]
*Main> enum' :: [Bar]
[Bar]
\end{verbatim}

Sources
\begin{verbatim}
  https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/default_signatures.html
\end{verbatim}


\begin{code}
{-# language DefaultSignatures #-}

class GEnum a where
  genum :: [a]
  default genum' :: Enum a => [a]
  


data Foo = Foo deriving Show
instance Enum' Foo
  
data Bar = Bar deriving (Enum, Show)
instance Enum' Bar where
  enum' = enumFrom Bar 
  
\end{code}

