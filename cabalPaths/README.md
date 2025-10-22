in the root directory with the cabal.project file, run 'cabal run t'

package d exports module Paths_d (Paths_<modulename>) with the data-dir value from d.cabal.
The d.cabal file must have the 'autogen-modules: Paths_d', and Paths_d must be listed in other-modules (if used within package d), or in exposed-modules (if Paths_d is to be used by another package.)

package t depends on package d, the Main.hs imports 'Paths_d' and invo=kes getDataDir.



