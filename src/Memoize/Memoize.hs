
import Data.Map

memoize :: Eq a => (a -> b) -> (a -> b)
memoize f = \a -> if
