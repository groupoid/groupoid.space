{-# OPTIONS --cubical --safe #-}

module Pushout where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Path
open import Cubical.Foundations.HLevels

-- Import universe levels
open import Agda.Primitive renaming (Level to ℓ)

-- Define the pushout type A ⊔_C B as a higher inductive type
-- Given a span A ← C → B
data Pushout {ℓ ℓ' ℓ''} (A : Type ℓ) (B : Type ℓ') (C : Type ℓ'')
             (f : C → A) (g : C → B) : Type (ℓ ⊔ ℓ' ⊔ ℓ'') where
  inl : A → Pushout A B C f g
  inr : B → Pushout A B C f g
  glue : (c : C) → Path (Pushout A B C f g) (inl (f c)) (inr (g c))

-- Dependent path type (PathOver)
PathOver : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
           {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
           (c : C) (u : D (inl (f c))) (v : D (inr (g c))) → Type ℓD
PathOver D c u v = PathP (λ i → D (glue c i)) u v

-- Dependent eliminator for Pushout A B C f g
pushoutInd : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
             {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
             (u : (a : A) → D (inl a))
             (v : (b : B) → D (inr b))
             (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
             → (x : Pushout A B C f g) → D x
pushoutInd D u v p (inl a) = u a
pushoutInd D u v p (inr b) = v b
pushoutInd D u v p (glue c i) = p c i

-- Computation rules
pushoutInd-β-inl : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
                   {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
                   (u : (a : A) → D (inl a)) (v : (b : B) → D (inr b))
                   (p : (c : C) → PathOver D c (u (f c)) (v (g c))) (a : A)
                   → pushoutInd D u v p (inl a) ≡ u a
pushoutInd-β-inl D u v p a = refl

pushoutInd-β-inr : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
                   {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
                   (u : (a : A) → D (inl a)) (v : (b : B) → D (inr b))
                   (p : (c : C) → PathOver D c (u (f c)) (v (g c))) (b : B)
                   → pushoutInd D u v p (inr b) ≡ v b
pushoutInd-β-inr D u v p b = refl

pushoutInd-β-glue : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
                    {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
                    (u : (a : A) → D (inl a)) (v : (b : B) → D (inr b))
                    (p : (c : C) → PathOver D c (u (f c)) (v (g c)))
                    (c : C) (i : I)
                    → pushoutInd D u v p (glue c i) ≡ p c i
pushoutInd-β-glue D u v p c i = refl

-- Uniqueness rule
-- Two dependent maps are homotopic if they agree on inl, inr, and glue
pushoutInd-unique : {ℓ ℓ' ℓ'' ℓD : ℓ} {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
                    {f : C → A} {g : C → B} (D : Pushout A B C f g → Type ℓD)
                    (h1 h2 : (x : Pushout A B C f g) → D x)
                    (e-inl : (a : A) → h1 (inl a) ≡ h2 (inl a))
                    (e-inr : (b : B) → h1 (inr b) ≡ h2 (inr b))
                    (e-glue : (c : C) → PathP (λ i → h1 (glue c i) ≡ h2 (glue c i))
                                        (e-inl (f c)) (e-inr (g c)))
                    → (x : Pushout A B C f g) → h1 x ≡ h2 x
pushoutInd-unique {ℓ} {ℓ'} {ℓ''} {ℓD} {A} {B} {C} {f} {g} D h1 h2 e-inl e-inr e-glue =
  pushoutInd E e-inl' e-inr' e-glue'
  where
    E : Pushout A B C f g → Type ℓD
    E x = h1 x ≡ h2 x

    e-inl' : (a : A) → E (inl a)
    e-inl' a = e-inl a

    e-inr' : (b : B) → E (inr b)
    e-inr' b = e-inr b

    e-glue' : (c : C) → PathOver E c (e-inl' (f c)) (e-inr' (g c))
    e-glue' c = e-glue c
