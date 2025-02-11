-- Example.hs

{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

import Options.Generic

data Example w = Example
    { foo :: w ::: Int <?> "Documentation for the foo flag"  <!> "0"
    , bar :: w ::: Double <?> "Documentation for the bar flag" <!> "-10.0"
    }  deriving (Generic)

instance ParseRecord (Example Wrapped)
deriving instance Show (Example Unwrapped)

main = do
    x <- unwrapRecord "Test program"
    print ( x :: Example Unwrapped)
