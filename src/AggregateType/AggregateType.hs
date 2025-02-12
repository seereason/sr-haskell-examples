{-# language TypeFamilies #-}
{-# language DataKinds #-}



type family Aggregate :: Type -> [Type] where
  Aggregate (a,b) = [a,b]
