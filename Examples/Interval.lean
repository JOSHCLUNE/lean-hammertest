import Mathlib.Data.Set.Intervals.Basic
import Mathlib.Data.Real.Basic
import Hammertest.DuperInterface

-- Standard TPTP Configs
set_option trace.auto.tptp.printQuery true
set_option trace.auto.tptp.result true
set_option auto.tptp.solver.name "zeport"
set_option auto.tptp.zeport.path "/home/indprinciple/Programs/zipperposition/portfolio/portfolio.fo.parallel.py"
-- Standard Native Configs
set_option trace.auto.native.printFormulas true
set_option auto.native.solver.func "Auto.duperRaw"

set_option auto.native true
set_option auto.tptp true

open Set
#check subset_def
#check mem_Icc
#check mem_Ico

example (a b c d : ℝ) (h1 : a < b) : Icc a b ⊆ Ico c d ↔ c ≤ a ∧ b < d := by
  rw [subset_def]
  auto [Set.mem_Icc, Set.mem_Ico, @le_trans, @le_total, @lt_iff_not_le, h1]

variable {α : Type _} [LinearOrder α]

example (a b c d : α) (h1 : a < b) : Icc a b ⊆ Ico c d ↔ c ≤ a ∧ b < d := by
  rw [subset_def]
  auto [Set.mem_Icc, Set.mem_Ico, @le_trans, @le_total, @lt_iff_not_le, h1]
