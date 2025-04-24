{-# OPTIONS --cubical --safe #-}

module HubSpokes where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)
open import Agda.Builtin.Nat renaming (Nat to ℕ)

-- Formation and Introduction: HubSpokes HIT
data HubSpokes {ℓS ℓA : Level} (S : Type ℓS) (A : Type ℓA) : Type (ℓS ⊔ ℓA) where
  base    : A → HubSpokes S A
  hub     : (S → HubSpokes S A) → HubSpokes S A
  spoke   : (f : S → HubSpokes S A) → (s : S) → hub f ≡ f s

-- Corrected induction principle
hubSpokesElim : {ℓS ℓA ℓ' : Level} {S : Type ℓS} {A : Type ℓA}
  (P : HubSpokes S A → Type ℓ')
  (pbase : (a : A) → P (base a))
  (phub : (f : S → HubSpokes S A) → P (hub f))
  (pf : (f : S → HubSpokes S A) → (s : S) → P (hub f))
  (pspoke : (f : S → HubSpokes S A) → (s : S) → phub f ≡ pf f s)
  → (z : HubSpokes S A) → P z
hubSpokesElim P pbase phub pf pspoke (base a) = pbase a
hubSpokesElim P pbase phub pf pspoke (hub f) = phub f
hubSpokesElim P pbase phub pf pspoke (spoke f s i) = ?
