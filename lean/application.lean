
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option
        open nat bool prod sum list classical option stream
   namespace application

      record app (P S: Type) := (spawn  : P → S)
                                (run    : S → P)
                                (action : P → S → S)

       check app

         end application

