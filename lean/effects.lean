
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option
   namespace effects open nat bool prod sum list classical option stream

      record eff        (x: Type)               := (carrier : x)
      record io         (x: Type) extends eff x := (get: unit → eff x) (put: x → eff x)
      record exception  (x: Type) extends eff x := (raise: x → eff x)
      record comm       (x: Type) extends eff x := (recv: unit → eff x) (send: x → eff x)

  definition unpure (x: Type) := Type → x → eff x

       definition a (x: Type) := prod.mk x x

       print a

         end effects
