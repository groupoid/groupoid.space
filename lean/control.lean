
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option
   namespace control open nat bool prod sum list classical option stream

      record pure (P: Type → Type) (A: Type) :=
             (return: P A)

      record functor (F: Type → Type) (A B: Type) :=
             (fmap: (A → B) → F A → F B)

      record applicative (F: Type → Type) (A B: Type) extends pure F A, functor F A B :=
             (ap: F (A → B) → F A → F B)

      record monad (F: Type → Type) (A B: Type) extends pure F A, functor F A B :=
             (join: F (F A) → F B)

      inductive weekday : Type := | sunday : weekday

        set_option pp.universes true
       eval ((Type → Type):Type)
       check (weekday : Type₁)

         end control
