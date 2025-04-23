{-# OPTIONS --cubical --safe #-}

module Suspension where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)

data Susp {ℓ} (A : Type ℓ) : Type ℓ where
  north : Susp A
  south : Susp A
  merid : (a : A) → north ≡ south

PathOver : {ℓ : ℓ} {A : Type ℓ}
  (B : Susp A → Type ℓ) (a : A) (n : B north) (s : B south) → Type ℓ
PathOver B a n s = PathP (λ i → B (merid a i)) n s

suspInd : {ℓ : ℓ} {A : Type ℓ}
  (B : Susp A → Type ℓ) (n : B north) (s : B south)
  (m : (a : A) → PathOver B a n s) → (x : Susp A) → B x
suspInd B n s m north = n
suspInd B n s m south = s
suspInd B n s m (merid a i) = m a i

suspInd-β-north : {ℓ : ℓ} {A : Type ℓ} (B : Susp A → Type ℓ) (n : B north)
  (s : B south) (m : (a : A) → PathOver B a n s) → suspInd B n s m north ≡ n
suspInd-β-north _ _ _ _ = refl

suspInd-β-south : {ℓ : ℓ} {A : Type ℓ} (B : Susp A → Type ℓ) (n : B north)
  (s : B south) (m : (a : A) → PathOver B a n s) → suspInd B n s m south ≡ s
suspInd-β-south _ _ _ _ = refl

suspInd-β-merid : {ℓ : ℓ} {A : Type ℓ} (B : Susp A → Type ℓ) (n : B north)
  (s : B south) (m : (a : A) → PathOver B a n s)
  (a : A) (i : I) → suspInd B n s m (merid a i) ≡ m a i
suspInd-β-merid _ _ _ _ _ _ = refl

suspInd-unique : {ℓ : ℓ} {A : Type ℓ} (B : Susp A → Type ℓ)
  (h1 h2 : (x : Susp A) → B x)
  (e-north : h1 north ≡ h2 north)
  (e-south : h1 south ≡ h2 south)
  (e-merid : (a : A) → PathP (λ i → h1 (merid a i) ≡ h2 (merid a i)) (e-north) (e-south))
  → (x : Susp A) → h1 x ≡ h2 x
suspInd-unique B h1 h2 e-north e-south e-merid =
  suspInd (λ x → h1 x ≡ h2 x) e-north e-south e-merid
