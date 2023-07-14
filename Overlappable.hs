{-# LANGUAGE FlexibleInstances #-}

class Printable a where
  printMe :: a -> IO ()

instance {-# OVERLAPPABLE #-} Printable a where
  printMe a = putStrLn "dummy instance"

instance Printable Int where
  printMe x = putStrLn ("I am an Int with value :" ++ show x)

-- > main
-- I am an Int with value :5
-- dummy instance
main :: IO ()
main = do
  printMe (5 :: Int)
  printMe ('x' :: Char)
