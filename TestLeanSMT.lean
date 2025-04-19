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
  runAutoOnConsts cfg declNames gtPremisesArr (withPrint := true)

set_option maxHeartbeats 200000000
#eval runAutoOnJson
  { solverConfig := .native, maxHeartbeats := 200000,
    logFile := "results/IntNamesAll.log", resultFile := "results/IntNamesAll.result",
    nonterminates := #[] }
  "/Users/joshClune/Desktop/ntp-toolkit/IntNamesAll.json"
