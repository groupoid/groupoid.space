{-# OPTIONS --cubical --safe #-}

module Colimit where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)
open import Agda.Builtin.Nat renaming (Nat to ℕ)

-- Sequence of types with maps
record Sequence (ℓ : Level) : Type (lsuc ℓ) where
  field
    A : ℕ → Type ℓ
    f : (n : ℕ) → A n → A (suc n)

-- Formation and Introduction: Colimit of a sequence of types
data Colimit {ℓ} (S : Sequence ℓ) : Type ℓ where
  inj   : (n : ℕ) → Sequence.A S n → Colimit S
  glue  : (n : ℕ) (a : Sequence.A S n) → PathP (λ i → Colimit S) (inj n a) (inj (suc n) (Sequence.f S n a))

-- PathOver for dependent paths over glue
PathOverGlue : {ℓ ℓ' : Level} {S : Sequence ℓ}
  (P : Colimit S → Type ℓ')
  (n : ℕ) (a : Sequence.A S n)
  (p : P (inj n a)) (q : P (inj (suc n) (Sequence.f S n a))) → Type ℓ'
PathOverGlue P n a p q = PathP (λ i → P (glue n a i)) p q

-- Elimination rule: Induction principle for Colimit
colimitInd : {ℓ ℓ' : Level} {S : Sequence ℓ}
  (P : Colimit S → Type ℓ')
  (pinj : (n : ℕ) (a : Sequence.A S n) → P (inj n a))
  (pglue : (n : ℕ) (a : Sequence.A S n) →
           PathOverGlue P n a (pinj n a) (pinj (suc n) (Sequence.f S n a)))
  → (z : Colimit S) → P z
colimitInd P pinj pglue (inj n a) = pinj n a
colimitInd P pinj pglue (glue n a i) = pglue n a i

-- Computation rules
colimitInd-β-inj : {ℓ ℓ' : Level} {S : Sequence ℓ}
  (P : Colimit S → Type ℓ')
  (pinj : (n : ℕ) (a : Sequence.A S n) → P (inj n a))
  (pglue : (n : ℕ) (a : Sequence.A S n) →
           PathOverGlue P n a (pinj n a) (pinj (suc n) (Sequence.f S n a)))
  (n : ℕ) (a : Sequence.A S n)
  → colimitInd P pinj pglue (inj n a) ≡ pinj n a
colimitInd-β-inj _ _ _ _ _ = refl

colimitInd-β-glue : {ℓ ℓ' : Level} {S : Sequence ℓ}
  (P : Colimit S → Type ℓ')
  (pinj : (n : ℕ) (a : Sequence.A S n) → P (inj n a))
  (pglue : (n : ℕ) (a : Sequence.A S n) →
           PathOverGlue P n a (pinj n a) (pinj (suc n) (Sequence.f S n a)))
  (n : ℕ) (a : Sequence.A S n) (i : I)
  → colimitInd P pinj pglue (glue n a i) ≡ pglue n a i
colimitInd-β-glue _ _ _ _ _ _ = refl

-- Uniqueness rule
colimitInd-unique : {ℓ ℓ' : Level} {S : Sequence ℓ}
  (P : Colimit S → Type ℓ')
  (h1 h2 : (z : Colimit S) → P z)
  (e-inj : (n : ℕ) (a : Sequence.A S n) → h1 (inj n a) ≡ h2 (inj n a))
  (e-glue : (n : ℕ) (a : Sequence.A S n) →
            PathP (λ i → h1 (glue n a i) ≡ h2 (glue n a i))
                  (e-inj n a) (e-inj (suc n) (Sequence.f S n a)))
  → (z : Colimit S) → h1 z ≡ h2 z
colimitInd-unique P h1 h2 e-inj e-glue =
  colimitInd (λ z → h1 z ≡ h2 z) e-inj e-glue
