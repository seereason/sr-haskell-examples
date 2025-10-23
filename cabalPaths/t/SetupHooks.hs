module SetupHooks where

-- Cabal-hooks
import Distribution.Simple.SetupHooks

setupHooks :: SetupHooks
setupHooks =
  noSetupHooks { preConfigurePackageHook = Just configureCustomPreProc }

configureCustomPreProc :: PreConfPackageInputs -> IO PreConfPackageOutputs
configureCustomPreProc pcpi@( PreConfPackageInputs { configFlags = cfg, localBuildConfig = lbc } ) = do
  let verbosity = fromFlag $ configVerbosity cfg
      progDb = withPrograms lbc
  configuredPreProcProg <-
    configureUnconfiguredProgram verbosity customPreProcProg progDb
  return $
    ( noPreConfPackageOutputs pcpi )
      { extraConfiguredProgs =
        Map.fromList
          [ ( customPreProcName, configuredPreProcProg ) ]
      }

customPreProcName :: String
customPreProcName = "customPreProc"

customPreProcProg :: Program
customPreProcProg =
  ( simpleProgram customPreProcName )
    { programFindLocation =
        -- custom logic to find the installed location of myPreProc
        -- on the system used to build the package
        myPreProcProgFindLocation
    , programFindVersion =
        -- custom logic to find the program version
        myPreProcProgFindVersion
    }
