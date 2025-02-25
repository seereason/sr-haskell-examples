{-# language DataKinds #-}
{-# language OverloadedLabels #-}
{-# language TemplateHaskell #-}
{-# language TypeFamilies #-}
{-# language OverloadedStrings #-}

import GHC.OverloadedLabels
import Data.String


instance IsLabel "click" EventName where
  fromLabel = EventName "click"

instance IsString EventName where
  fromString = EventName


newtype EventName = EventName { unEventName :: String } deriving Show

-- this works nicely, generating a type error if the eventname doesn't exist.
on :: EventName -> EventName
on = id


-- this would need a runtime check, as far as I can see.
-- I was interested in this because MicroHS doesn't support DataKinds, OverloadedLabels.
-- It does support TypeLits, though. Maybe there is a way to do it.
on2 :: EventName -> EventName
on2 = id
