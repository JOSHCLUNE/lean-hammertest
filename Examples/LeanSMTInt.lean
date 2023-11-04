/-
These are examples borrowed from the SMT Lean tests,
`https://github.com/ufmg-smite/lean-smt/blob/main/Test/Int`
-/
import Mathlib.Data.Real.Basic
import Auto.Tactic

set_option auto.smt true
set_option auto.smt.trust true
set_option trace.auto.smt.printCommands true
set_option trace.auto.smt.result true
set_option trace.auto.lamReif.printResult true
set_option auto.smt.solver.name "cvc5"

-- Arith
example (n m : Int) : (n % m) + (n / m) * m = n := by
  auto

example (m : Int) : m % 0 = m := by
  auto

example (n m : Int) : m ≠ 0 → n % m ≥ 0 := by
  auto

example (n m : Int) (h : 0 < m) : n % m < m := by
  auto

#eval (-11) % (-4)
example : ((-11) % (-4)) = 1 := by
  auto

#eval ((-11) / (-4))
example : ((-11) / (-4)) = 3 := by
  auto

example (n m : Int) : (Int.mod n m) + (Int.div n m) * m = n := by
  auto

example (m : Int) : Int.mod m 0 = m := by
  auto

example (n m : Int) : (m > 0 → Int.mod n m < m) ∧ (m < 0 → Int.mod n m > m) := by
  auto

example (n m : Int) (h₁ : 0 < m) (h₂ : 0 < n) : Int.div n m ≤ n := by
  auto

#eval (Int.mod (-11) (-4))
example : (Int.mod (-11) (-4)) = -3 := by
  auto

#eval Int.div (-14) (-4)
example : Int.div (-14) (-4) = 3 := by
  auto

example (n m k l : Int) : (n - m) * k + l = n*k - m*k + l := by
  auto

example (n m k l : Int) (hN : n ≥ m) (hK : k ≥ l) : n + k ≥ m + l := by
  --smt [hN, hK]
  auto

example (n m k l : Int) (hN : n ≤ m) (hK : k ≤ l) : n + k ≤ m + l := by
  --smt [hN, hK]
  auto

-- Cong

theorem cong (x y : Int) (f : Int → Int) : x = y → f x = f y := by
  auto

-- DefineSort

def MyInt := Int
def MyInt.add (a b : MyInt) : MyInt := Int.add a b

example (a b : MyInt) : a.add b = b.add a := by
  auto u[MyInt] d[MyInt.add]

-- Dvd

opaque dvd : Int → Int → Bool

example
    (a b c d e : Int)
    (dvdax : ∀ x y z, dvd x y → dvd y z → dvd x z)
    (h1 : dvd a b)
    (h2 : dvd b c)
    (h3 : dvd c d)
    (h4 : dvd d e) :
  dvd a e := by
    auto

-- ForallExists

theorem forallExists : ∀ x : Nat, ∃ y : Int, x ≤ y := by
  auto

-- Let

section
variable (f : Int → Int)

example (h : f 10 = 10) : let y := 10; f y = 10 := by
  auto

example (h : let y := 10; f y = 10) : f 10 = 10 := by
  auto

example (h : f 10 = 10) : f 10 = 10 := by
  auto

theorem neg (x : Int) : - -x = x := by
  auto

end
