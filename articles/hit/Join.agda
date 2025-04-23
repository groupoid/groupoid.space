{-# OPTIONS --cubical --safe #-}

module Join where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)

-- Formation and Introduction: Join of two types
data Join {ℓ ℓ'} (A : Type ℓ) (B : Type ℓ') : Type (ℓ ⊔ ℓ') where
  inl   : A → Join A B
  inr   : B → Join A B
  push  : (a : A) (b : B) → PathP (λ i → Join A B) (inl a) (inr b)

-- PathOver for dependent paths over push
PathOverPush : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (a : A) (b : B)
  (p : P (inl a)) (q : P (inr b)) → Type ℓ''
PathOverPush P a b p q = PathP (λ i → P (push a b i)) p q

-- Elimination rule: Induction principle for Join
joinInd : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (pinl : (a : A) → P (inl a))
  (pinr : (b : B) → P (inr b))
  (ppush : (a : A) (b : B) → PathOverPush P a b (pinl a) (pinr b))
  → (z : Join A B) → P z
joinInd P pinl pinr ppush (inl a) = pinl a
joinInd P pinl pinr ppush (inr b) = pinr b
joinInd P pinl pinr ppush (push a b i) = ppush a b i

-- Computation rules
joinInd-β-inl : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (pinl : (a : A) → P (inl a))
  (pinr : (b : B) → P (inr b))
  (ppush : (a : A) (b : B) → PathOverPush P a b (pinl a) (pinr b))
  (a : A)
  → joinInd P pinl pinr ppush (inl a) ≡ pinl a
joinInd-β-inl _ _ _ _ _ = refl

joinInd-β-inr : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (pinl : (a : A) → P (inl a))
  (pinr : (b : B) → P (inr b))
  (ppush : (a : A) (b : B) → PathOverPush P a b (pinl a) (pinr b))
  (b : B)
  → joinInd P pinl pinr ppush (inr b) ≡ pinr b
joinInd-β-inr _ _ _ _ _ = refl

joinInd-β-push : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (pinl : (a : A) → P (inl a))
  (pinr : (b : B) → P (inr b))
  (ppush : (a : A) (b : B) → PathOverPush P a b (pinl a) (pinr b))
  (a : A) (b : B) (i : I)
  → joinInd P pinl pinr ppush (push a b i) ≡ ppush a b i
joinInd-β-push _ _ _ _ _ _ _ = refl

-- Uniqueness rule
joinInd-unique : {ℓ ℓ' ℓ'' : Level} {A : Type ℓ} {B : Type ℓ'}
  (P : Join A B → Type ℓ'')
  (h1 h2 : (z : Join A B) → P z)
  (e-inl : (a : A) → h1 (inl a) ≡ h2 (inl a))
  (e-inr : (b : B) → h1 (inr b) ≡ h2 (inr b))
  (e-push : (a : A) (b : B) →
            PathP (λ i → h1 (push a b i) ≡ h2 (push a b i)) (e-inl a) (e-inr b))
  → (z : Join A B) → h1 z ≡ h2 z
joinInd-unique P h1 h2 e-inl e-inr e-push =
  joinInd (λ z → h1 z ≡ h2 z) e-inl e-inr e-push
