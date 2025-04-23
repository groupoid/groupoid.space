{-# OPTIONS --cubical --safe #-}

module Wedge where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)

-- Pointed type: a type with a distinguished point
record Pointed (ℓ : Level) : Type (lsuc ℓ) where
  constructor MkPointed
  field
    typ : Type ℓ
    pt  : typ

-- Formation and Introduction: Wedge sum type for two pointed types
data Wedge {ℓ ℓ'} (A : Pointed ℓ) (B : Pointed ℓ') : Type (ℓ ⊔ ℓ') where
  inl   : Pointed.typ A → Wedge A B
  inr   : Pointed.typ B → Wedge A B
  glue  : PathP (λ i → Wedge A B) (inl (Pointed.pt A)) (inr (Pointed.pt B))

-- PathOver for dependent paths over glue
PathOverGlue : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (p : P (inl (Pointed.pt A))) (q : P (inr (Pointed.pt B))) → Type ℓ''
PathOverGlue P p q = PathP (λ i → P (glue i)) p q

-- Elimination rule: Induction principle for Wedge
wedgeInd : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (pinl : (a : Pointed.typ A) → P (inl a))
  (pinr : (b : Pointed.typ B) → P (inr b))
  (pglue : PathOverGlue P (pinl (Pointed.pt A)) (pinr (Pointed.pt B)))
  → (z : Wedge A B) → P z
wedgeInd P pinl pinr pglue (inl a) = pinl a
wedgeInd P pinl pinr pglue (inr b) = pinr b
wedgeInd P pinl pinr pglue (glue i) = pglue i

-- Computation rules
wedgeInd-β-inl : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (pinl : (a : Pointed.typ A) → P (inl a))
  (pinr : (b : Pointed.typ B) → P (inr b))
  (pglue : PathOverGlue P (pinl (Pointed.pt A)) (pinr (Pointed.pt B)))
  (a : Pointed.typ A)
  → wedgeInd P pinl pinr pglue (inl a) ≡ pinl a
wedgeInd-β-inl _ _ _ _ _ = refl

wedgeInd-β-inr : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (pinl : (a : Pointed.typ A) → P (inl a))
  (pinr : (b : Pointed.typ B) → P (inr b))
  (pglue : PathOverGlue P (pinl (Pointed.pt A)) (pinr (Pointed.pt B)))
  (b : Pointed.typ B)
  → wedgeInd P pinl pinr pglue (inr b) ≡ pinr b
wedgeInd-β-inr _ _ _ _ _ = refl

wedgeInd-β-glue : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (pinl : (a : Pointed.typ A) → P (inl a))
  (pinr : (b : Pointed.typ B) → P (inr b))
  (pglue : PathOverGlue P (pinl (Pointed.pt A)) (pinr (Pointed.pt B)))
  (i : I)
  → wedgeInd P pinl pinr pglue (glue i) ≡ pglue i
wedgeInd-β-glue _ _ _ _ _ = refl

-- Uniqueness rule
wedgeInd-unique : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Wedge A B → Type ℓ'')
  (h1 h2 : (z : Wedge A B) → P z)
  (e-inl : (a : Pointed.typ A) → h1 (inl a) ≡ h2 (inl a))
  (e-inr : (b : Pointed.typ B) → h1 (inr b) ≡ h2 (inr b))
  (e-glue : PathP (λ i → h1 (glue i) ≡ h2 (glue i)) (e-inl (Pointed.pt A)) (e-inr (Pointed.pt B)))
  → (z : Wedge A B) → h1 z ≡ h2 z
wedgeInd-unique P h1 h2 e-inl e-inr e-glue =
  wedgeInd (λ z → h1 z ≡ h2 z) e-inl e-inr e-glue
