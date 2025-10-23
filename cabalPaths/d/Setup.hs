

import Distribution.Simple
import Distribution.Types.PackageDescription
import Distribution.Utils.Path (getAbsolutePath, getSymbolicPath)
import System.IO
import System.Directory
import System.FilePath

main = defaultMainWithHooks simpleUserHooks { postBuild = buildhook }


buildhook args flags desc info = do
  let dir = getSymbolicPath (dataDir desc)
  --ilet dir = getAbsolutePath (dataDir desc)
  (\d -> print ("CWD",d)) =<< getCurrentDirectory
  print ("dataDir",dir)
  writeFile (dir </> "foo.dat")  "foo\nbar\nsam\n"

