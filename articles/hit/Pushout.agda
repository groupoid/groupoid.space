{-# OPTIONS --cubical --safe #-}

module Pushout where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels
open import Agda.Primitive renaming (Level to ℓ)

data Pushout {ℓ} (A B C : Type ℓ) (f : C → A) (g : C → B) : Type ℓ where
  inl : A → Pushout A B C f g
  inr : B → Pushout A B C f g
  glue : (c : C) → inl (f c) ≡ inr (g c)

PathOver : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (c : C)
  (u : D (inl (f c))) (v : D (inr (g c))) → Type ℓ
PathOver D c u v = PathP (λ i → D (glue c i)) u v

pushoutInd : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (u : (a : A) → D (inl a))
  (v : (b : B) → D (inr b)) (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
  → (x : Pushout A B C f g) → D x
pushoutInd D u v p (inl a) = u a
pushoutInd D u v p (inr b) = v b
pushoutInd D u v p (glue c i) = p c i

pushoutInd-β-inl : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (u : (a : A) → D (inl a))
  (v : (b : B) → D (inr b)) (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
  (a : A) → pushoutInd D u v p (inl a) ≡ u a
pushoutInd-β-inl _ _ _ _ _ = refl

pushoutInd-β-inr : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (u : (a : A) → D (inl a))
  (v : (b : B) → D (inr b)) (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
  (b : B) → pushoutInd D u v p (inr b) ≡ v b
pushoutInd-β-inr _ _ _ _ _ = refl

pushoutInd-β-glue : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (u : (a : A) → D (inl a))
  (v : (b : B) → D (inr b)) (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
  (c : C) (i : I) → pushoutInd D u v p (glue c i) ≡ p c i
pushoutInd-β-glue _ _ _ _ _ _ = refl

pushoutInd-unique : {ℓ : ℓ} {A B C : Type ℓ} {f : C → A} {g : C → B}
  (D : Pushout A B C f g → Type ℓ) (h1 h2 : (x : Pushout A B C f g) → D x)
  (e-inl : (a : A) → h1 (inl a) ≡ h2 (inl a))
  (e-inr : (b : B) → h1 (inr b) ≡ h2 (inr b))
  (e-glue : (c : C) → PathP (λ i → h1 (glue c i) ≡ h2 (glue c i))
  (e-inl (f c)) (e-inr (g c))) → (x : Pushout A B C f g) → h1 x ≡ h2 x
pushoutInd-unique D h1 h2 e-inl e-inr e-glue =
  pushoutInd (λ x → h1 x ≡ h2 x) e-inl e-inr e-glue
