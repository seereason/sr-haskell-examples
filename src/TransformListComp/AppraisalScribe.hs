{-# LANGUAGE TransformListComp #-}

import GHC.Exts

import Data.Map

type Ident = Int
type Checksum = String
type Report = (Ident, [Image], [Property])

type Image = (Checksum, FilePath)
type Property = (Int, String, [Image])


reports :: [Report]
reports = [ (0, [], [] ) ]

output = [ (rid, ims, ps)
         | (rid, ims, ps) <- reports
         ]

