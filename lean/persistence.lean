
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option
        open nat bool prod sum list classical option stream
   namespace persistence

  definition ids       := option ℕ
      record table     := (name: string) (attr: list string) (keys: list string) (gen: ℕ)
      record container := (top: ids) (size: ℕ) (carrier: Type)
      record iterator  := (id: ids) (next: ids) (prev: ids) (carrier: Type)
   inductive direction := forward | backward
      record proto     := (data: iterator)

         end persistence
