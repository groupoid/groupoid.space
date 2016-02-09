
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option
             application persistence storage effects
        open nat bool prod sum list classical option stream
             application persistence storage effects

   namespace cat

      record category (P S: Type) := (spawn  : P → S)
                                (run    : S → P)
                                (action : P → S → S)

       check action

         end cat
