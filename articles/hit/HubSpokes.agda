{-# OPTIONS --cubical --safe #-}

module HubSpokes where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)
open import Agda.Builtin.Nat renaming (Nat to ℕ)

-- Formation: HubSpokes type with explicit level parameters
data HubSpokes {ℓS ℓA : Level} (S : Type ℓS) (A : Type ℓA) : Type (ℓS ⊔ ℓA) where
  base    : A → HubSpokes S A
  hub     : (S → HubSpokes S A) → HubSpokes S A
  spoke   : (f : S → HubSpokes S A) → (s : S) → PathP (λ i → HubSpokes S A) (hub f) (f s)
  hubEq   : (x y : A) → (p : S → Path A x y) → PathP (λ i → HubSpokes S A) (base x) (base y)
  spokeEq : (x y : A) → (p : S → Path A x y) → (s : S) → PathP (λ i → PathP (λ j → HubSpokes S A) (base x) (base y)) (hubEq x y p) (cong base (p s))

-- PathOver for dependent paths over spoke, hubEq, and spokeEq
PathOverSpoke : {ℓS ℓA ℓ' : Level} {S : Type ℓS} {A : Type ℓA}
  (P : HubSpokes S A → Type ℓ')
  (f : S → HubSpokes S A) (s : S)
  (p : P (hub f)) (q : P (f s)) → Type ℓ'
PathOverSpoke P f s p q = PathP (λ i → P (spoke f s i)) p q

PathOverHubEq : {ℓS ℓA ℓ' : Level} {S : Type ℓS} {A : Type ℓA}
  (P : HubSpokes S A → Type ℓ')
  (x y : A) (p : S → Path A x y)
  (px : P (base x)) (py : P (base y)) → Type ℓ'
PathOverHubEq P x y p px py = PathP (λ i → P (hubEq x y p i)) px py

PathOverSpokeEq : {ℓS ℓA ℓ' : Level} {S : Type ℓS} {A : Type ℓA}
  (P : HubSpokes S A → Type ℓ')
  (x y : A) (p : S → Path A x y) (s : S)
  (a : P (base x)) (b : P (base y))
  (ph : PathP (λ j → P (hubEq x y p j)) a b)
  (pb : PathP (λ j → P (cong base (p s) j)) a b) → Type ℓ'
PathOverSpokeEq P x y p s a b ph pb = PathP (λ i → PathP (λ k → P (spokeEq x y p s i k)) a b) ph pb

