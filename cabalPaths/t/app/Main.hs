module Main (main) where

import Paths_d

main :: IO ()
main = do
  print ("version :: Version", version)
  mapM_ ppath paths
  where ppath (label,io) = do  { p <- io ; print (label,p); }
        paths = [ ("getDataDir",getDataDir)
                , ("getBinDir",getBinDir)
                , ("getLibDir",getLibDir)
                , ("getDynLibDir",getDynLibDir)
                , ("getDataDir",getDataDir)
                , ("getLibexecDir",getLibexecDir)
                , ("getSysconfDir",getSysconfDir)
                ]
