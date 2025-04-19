import Auto.Tactic
/- Commenting out because we don't have Duper as a dependency
import Duper.Tactic

open Lean Auto

def Auto.duperRaw (lemmas : Array Lemma) (inhs : Array Lemma) : MetaM Expr := do
  let lemmas : Array (Expr × Expr × Array Name × Bool) ← lemmas.mapM
    (fun ⟨⟨proof, ty, _⟩, _⟩ => do return (ty, ← Meta.mkAppM ``eq_true #[proof], #[], true))
  Duper.runDuper lemmas.toList 0

def Auto.duperPort (lemmas : Array Lemma) (inhs : Array Lemma) : MetaM Expr := do
  let lemmas : Array (Expr × Expr × Array Name × Bool) ← lemmas.mapM
    (fun ⟨⟨proof, ty, _⟩, _⟩ => do return (ty, ← Meta.mkAppM ``eq_true #[proof], #[], true))
  Duper.runDuperPortfolioMode
    (lemmas.toList.map (fun ⟨e₁, e₂, ns, b⟩ => ⟨e₁, e₂, ns, b, .none⟩))
    .none ⟨true, .none, .none, .none, .none, .none⟩ .none
-/
