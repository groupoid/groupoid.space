{-# OPTIONS --cubical --safe #-}

module PiTypeIso where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels
open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Univalence
open import Cubical.Data.Sigma
open import Cubical.Data.Unit
open import Cubical.Core.Primitives
open import Agda.Primitive

-- Universe levels
private
  variable
    ℓ ℓ₀ ℓ₁ ℓ₂ : Level

-- Category definition
record Category (ℓ₀ ℓ₁ : Level) : Type (lsuc (ℓ₀ ⊔ ℓ₁)) where
  field
    ob : Type ℓ₀
    hom : ob → ob → Type ℓ₁
    id : ∀ {A} → hom A A
    _∘_ : ∀ {A B C} → hom B C → hom A B → hom A C
    idL : ∀ {A B} (f : hom A B) → id ∘ f ≡ f
    idR : ∀ {A B} (f : hom A B) → f ∘ id ≡ f
    assoc : ∀ {A B C D} (f : hom C D) (g : hom B C) (h : hom A B) → (f ∘ g) ∘ h ≡ f ∘ (g ∘ h)
    isSetHom : ∀ {A B} → isSet (hom A B)

-- Slice category
Slice : Category ℓ₀ ℓ₁ → Category.ob _ → Category ℓ₀ ℓ₁
Slice {ℓ₀} {ℓ₁} C X = record
  { ob = Σ[ A ∈ Category.ob C ] (Category.hom C A X)
  ; hom = λ { (A , p) (B , q) → Σ[ f ∈ Category.hom C A B ] (p ≡ q ∘ f) }
  ; id = λ { (A , p) → (id , sym (idR p)) }
  ; _∘_ = λ { { (A , p) } { (B , q) } { (C , r) } (g , gq) (f , fp) → (_∘_ g f , transport (λ i → p ≡ (assoc r g f (~ i)) ∘ (g ∘ f)) (fp ∙ gq)) }
  ; idL = λ { { (A , p) } { (B , q) } (f , fp) → ΣPathP (idL f , toPathP (isSetHom _ _ _ _)) }
  ; idR = λ { { (A , p) } { (B , q) } (f , fp) → ΣPathP (idR f , toPathP (isSetHom _ _ _ _)) }
  ; assoc = λ { { (A , p) } { (B , q) } { (C , r) } { (D , s) } (h , hq) (g , gr) (f , fp) → ΣPathP (assoc h g f , toPathP (isSetHom _ _ _ _)) }
  ; isSetHom = λ { (A , p) (B , q) → isSetΣ (isSetHom A B) (λ _ → isProp→isSet (isSetHom _ _ _ _)) }
  }
  where
    open Category C

-- Locally Cartesian closed category (simplified)
record LCCC (ℓ₀ ℓ₁ : Level) : Type (lsuc (lsuc (ℓ₀ ⊔ ℓ₁))) where
  field
    cat : Category ℓ₀ ℓ₁
    terminal : Σ[ ⊤ ∈ Category.ob cat ] (∀ X → isContr (Category.hom cat X ⊤))
    weakening : ∀ {X Y} (f : Category.hom cat Y X) → Slice cat X → Slice cat Y
    pi : ∀ {X Y} (f : Category.hom cat Y X) → Slice cat Y → Slice cat X
    eval : ∀ {X Y} (f : Category.hom cat Y X) (B : Slice cat Y) →
           Category.hom (Slice cat Y) (weakening f (pi f B)) B
    universal : ∀ {X Y} (f : Category.hom cat Y X) (B : Slice cat Y) (Z : Slice cat X)
                (s : Category.hom (Slice cat Y) (weakening f Z) B) →
                Σ[ h ∈ Category.hom (Slice cat X) Z (pi f B) ] (Category._∘_ (Slice cat Y) (eval f B) (weakening f h) ≡ s)
    unique : ∀ {X Y} (f : Category.hom cat Y X) (B : Slice cat Y) (Z : Slice cat X)
               (s : Category.hom (Slice cat Y) (weakening f Z) B)
               (h1 h2 : Category.hom (Slice cat X) Z (pi f B)) →
               Category._∘_ (Slice cat Y) (eval f B) (weakening f h1) ≡ s →
               Category._∘_ (Slice cat Y) (eval f B) (weakening f h2) ≡ s →
               h1 ≡ h2

-- Π-type isomorphism proof
module PiIso {ℓ₀ ℓ₁ : Level} (C : LCCC ℓ₀ ℓ₁) {Γ X : Category.ob (LCCC.cat C)}
             (p : Category.hom (LCCC.cat C) X Γ) (B : Slice (LCCC.cat C) X)
             (Y : Slice (LCCC.cat C) Γ) where
  open LCCC C
  open Category cat

  -- Encode: h : Y → Π_p B ↦ ε ∘ p^* h : p^* Y → B
  encode : Category.hom (Slice cat Γ) Y (pi p B) → Category.hom (Slice cat X) (weakening p Y) B
  encode h = eval p B ∘ (weakening p h)

  -- Decode: s : p^* Y → B ↦ h : Y → Π_p B such that ε ∘ p^* h = s
  decode : Category.hom (Slice cat X) (weakening p Y) B → Category.hom (Slice cat Γ) Y (pi p B)
  decode s = fst (universal p B Y s)

  -- Section: encode ∘ decode = id (β-reduction)
  sectionIso : ∀ s → encode (decode s) ≡ s
  sectionIso s = snd (universal p B Y s)

  -- Retract: decode ∘ encode = id (η-conversion)
  retractIso : ∀ h → decode (encode h) ≡ h
  retractIso h = unique p B Y (encode h) (decode (encode h)) h
                      (snd (universal p B Y (encode h))) refl

  -- Isomorphism between hom-sets
  homIso : Iso (Category.hom (Slice cat Γ) Y (pi p B)) (Category.hom (Slice cat X) (weakening p Y) B)
  homIso = iso encode decode sectionIso retractIso
