import Lake
open Lake DSL

package hammertest {
  -- add package configuration options here
}

require smt from git "https://github.com/JOSHCLUNE/lean-smt.git" @ "main"

lean_lib Hammertest {
  -- add library configuration options here
}

lean_lib TestLeanSMT

@[default_target]
lean_exe hammertest {
  root := `Main
}
