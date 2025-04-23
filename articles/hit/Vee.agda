{-# OPTIONS --cubical --safe #-}

module Vee where

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

-- Formation and Introduction: Smash product type for two pointed types
data Smash {ℓ ℓ'} (A : Pointed ℓ) (B : Pointed ℓ') : Type (ℓ ⊔ ℓ') where
  basel : Smash A B
  baser : Smash A B
  proj  : Pointed.typ A → Pointed.typ B → Smash A B
  gluel : (a : Pointed.typ A) → PathP (λ i → Smash A B) (proj a (Pointed.pt B)) basel
  gluer : (b : Pointed.typ B) → PathP (λ i → Smash A B) (proj (Pointed.pt A) b) baser

-- PathOver for dependent paths over gluel and gluer
PathOverGluel : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'') (a : Pointed.typ A)
  (p : P (proj a (Pointed.pt B))) (b : P basel) → Type ℓ''
PathOverGluel P a p b = PathP (λ i → P (gluel a i)) p b

PathOverGluer : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'') (b : Pointed.typ B)
  (p : P (proj (Pointed.pt A) b)) (b' : P baser) → Type ℓ''
PathOverGluer P b p b' = PathP (λ i → P (gluer b i)) p b'

-- Elimination rule: Induction principle for Smash
smashInd : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  → (z : Smash A B) → P z
smashInd P pbasel pbaser pproj pgluel pgluer basel = pbasel
smashInd P pbasel pbaser pproj pgluel pgluer baser = pbaser
smashInd P pbasel pbaser pproj pgluel pgluer (proj x y) = pproj x y
smashInd P pbasel pbaser pproj pgluel pgluer (gluel a i) = pgluel a i
smashInd P pbasel pbaser pproj pgluel pgluer (gluer b i) = pgluer b i

-- Computation rules
smashInd-β-basel : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  → smashInd P pbasel pbaser pproj pgluel pgluer basel ≡ pbasel
smashInd-β-basel _ _ _ _ _ _ = refl

smashInd-β-baser : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  → smashInd P pbasel pbaser pproj pgluel pgluer baser ≡ pbaser
smashInd-β-baser _ _ _ _ _ _ = refl

smashInd-β-proj : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  (x : Pointed.typ A) (y : Pointed.typ B)
  → smashInd P pbasel pbaser pproj pgluel pgluer (proj x y) ≡ pproj x y
smashInd-β-proj _ _ _ _ _ _ _ _ = refl

smashInd-β-gluel : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  (a : Pointed.typ A) (i : I)
  → smashInd P pbasel pbaser pproj pgluel pgluer (gluel a i) ≡ pgluel a i
smashInd-β-gluel _ _ _ _ _ _ _ _ = refl

smashInd-β-gluer : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (pbasel : P basel)
  (pbaser : P baser)
  (pproj : (x : Pointed.typ A) → (y : Pointed.typ B) → P (proj x y))
  (pgluel : (a : Pointed.typ A) → PathOverGluel P a (pproj a (Pointed.pt B)) pbasel)
  (pgluer : (b : Pointed.typ B) → PathOverGluer P b (pproj (Pointed.pt A) b) pbaser)
  (b : Pointed.typ B) (i : I)
  → smashInd P pbasel pbaser pproj pgluel pgluer (gluer b i) ≡ pgluer b i
smashInd-β-gluer _ _ _ _ _ _ _ _ = refl

-- Uniqueness rule
smashInd-unique : {ℓ ℓ' ℓ'' : Level} {A : Pointed ℓ} {B : Pointed ℓ'}
  (P : Smash A B → Type ℓ'')
  (h1 h2 : (z : Smash A B) → P z)
  (e-basel : h1 basel ≡ h2 basel)
  (e-baser : h1 baser ≡ h2 baser)
  (e-proj : (x : Pointed.typ A) (y : Pointed.typ B) → h1 (proj x y) ≡ h2 (proj x y))
  (e-gluel : (a : Pointed.typ A) → PathP (λ i → h1 (gluel a i) ≡ h2 (gluel a i)) (e-proj a (Pointed.pt B)) e-basel)
  (e-gluer : (b : Pointed.typ B) → PathP (λ i → h1 (gluer b i) ≡ h2 (gluer b i)) (e-proj (Pointed.pt A) b) e-baser)
  → (z : Smash A B) → h1 z ≡ h2 z
smashInd-unique P h1 h2 e-basel e-baser e-proj e-gluel e-gluer =
  smashInd (λ z → h1 z ≡ h2 z) e-basel e-baser e-proj e-gluel e-gluer
