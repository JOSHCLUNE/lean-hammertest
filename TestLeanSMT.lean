import Mathlib
import Hammertest.DuperInterface
import Auto.EvaluateAuto.TestAuto
import Smt
import Smt.Auto
import Smt.Real

open Lean Meta Elab Auto EvalAuto

def runAutoOnJson (cfg : EvalAutoConfig) (fname : String) : CoreM Unit := do
  let fd ← IO.FS.Handle.mk fname .read
  let s ← fd.readToEnd
  let jsonEntry ← IO.ofExcept $ Json.parse s
  let declName ← IO.ofExcept $ jsonEntry.getObjVal? "decl_name"
  let gtPremises ← IO.ofExcept $ jsonEntry.getObjVal? "gt_premises"
  let declName ← IO.ofExcept $ declName.getStr?
  let gtPremises ← IO.ofExcept $ gtPremises.getArr?
  let gtPremises ← gtPremises.mapM (fun p => IO.ofExcept (p.getStr?))
  let declName := declName.toName
  let gtPremises := gtPremises.map String.toName
  runAutoOnConsts cfg #[declName] #[gtPremises]
  
  /- Code for when there are multiple json elements in one file
  let json ← IO.ofExcept $ Json.parse s
  let jsonArr ← IO.ofExcept $ json.getArr?
  let mut declNames := #[]
  let mut gtPremisesArr := #[]
  for jsonEntry in jsonArr do
    let declName ← IO.ofExcept $ jsonEntry.getObjVal? "decl_name"
    let gtPremises ← IO.ofExcept $ jsonEntry.getObjVal? "gt_premises"
    let declName ← IO.ofExcept $ declName.getStr?
    let gtPremises ← IO.ofExcept $ gtPremises.getArr?
    let gtPremises ← gtPremises.mapM (fun p => IO.ofExcept (p.getStr?))
    let declName := declName.toName
    let gtPremises := gtPremises.map String.toName
    declNames := declNames.push declName
    gtPremisesArr := gtPremisesArr.push gtPremises
  runAutoOnConsts cfg declNames gtPremisesArr
  -/

/-
set_option maxHeartbeats 200000000
#eval runAutoOnJson
  { solverConfig := .native, maxHeartbeats := 200000,
    logFile := "results/IntNamesTwo.log", resultFile := "results/IntNamesTwo.result",
    nonterminates := #[] }
  "IntNamesTwo.json"
  -- "/Users/joshClune/Desktop/ntp-toolkit/IntNamesAll.json"
-/

def runAutoOnJsonNoArg : CoreM Unit := do
  let cfg : EvalAutoConfig :=
    { solverConfig := .native, maxHeartbeats := 200000,
      logFile := "results/ListNamesAll.log", resultFile := "results/ListNamesAll.result",
      nonterminates := #[] }
  let #[nextFile] ← IO.FS.lines "nextFile.txt"
    | throwError "Bad nextFile.txt"
  runAutoOnJson cfg nextFile

#eval runAutoOnJsonNoArg
