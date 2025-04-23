{-# OPTIONS --cubical --safe #-}

module Suspension where
open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Agda.Primitive renaming (Level to ℓ)

-- Define the suspension type Σ A as a higher inductive type
data Susp {ℓ} (A : Type ℓ) : Type ℓ where
  north : Susp A
  south : Susp A
  merid : (a : A) → Path (Susp A) north south

-- Dependent path type (PathOver)
PathOver : {ℓ ℓ' : ℓ} {A : Type ℓ}
  (B : Susp A → Type ℓ') (a : A) (n : B north) (s : B south) → Type ℓ'
PathOver B a n s = PathP (λ i → B (merid a i)) n s

suspInd : {ℓ ℓ' : ℓ} {A : Type ℓ}
  (B : Susp A → Type ℓ') (n : B north) (s : B south)
  (m : (a : A) → PathOver B a n s) → (x : Susp A) → B x
suspInd B n s m north = n
suspInd B n s m south = s
suspInd B n s m (merid a i) = m a i
