
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option application persistence
        open nat bool prod sum list classical option stream application persistence
   namespace storage

      record db     extends proto
      record add    extends db
      record reduce extends db := (dir:  direction)
      record remove extends db
      record ok     extends proto
      record error  extends proto
  definition kvs    := add + remove + reduce + ok + error

      record person extends iterator := (names: list string)
      record group  extends iterator := (name:  list string)

      record store
     extends app proto container :=
             (sup: list container)
             (tab: list table)
             (calculation: iterator → container → container)

  definition carrier (x: container) : Type     := match x with {| container, carrier := v |} := v end
  definition top     (x: container) : ids      := match x with {| container, top := v |}   := v end
  definition size    (x: container) : ℕ        := match x with {| container, size := v |}  := v end
  definition next    (x: iterator)  : ids      := match x with {| iterator, next := v |}   := v end
  definition data    (x: proto)     : iterator := match x with {| proto, data := v |}      := v end
  definition id      (x: iterator)  : ids         := match x with {| iterator, id := v |}  := v end
  definition names   (x: person)    : list string := match x with {| person, names := v |} := v end
  definition action  (x: store)     : proto → container → container :=  match x with {| store, action := v |} := v end
  definition cal : iterator → container → container := λ x y, container.mk (id x) (addl (size y) 1) (carrier y)
  definition act : proto → container → container := λ x y, cal (data x) y

       check group
       print prefix names
       print instances inhabited
        eval (names (person.mk (some 0) (some 0) (some 0) ℕ (cons "maxim" nil)))
       print "maxim"
       check action

  definition new_container (x: Type) := {| container, top := none, size := 0, carrier := x |}
  definition new_store     := {| store,
                         sup := nil,
                         tab := nil,
                       spawn := λ x, new_container person,
                         run := λ x, ok.mk (iterator.mk (some 0) none none (carrier x)),
                 calculation := λ x y, container.mk (id x) (addl (size y) 1) (carrier y),
                      action := λ x y, cal (data x) y |}

        eval (action new_store) (add.mk (person.mk (some 11) none none person nil))
                                ((action new_store) (add.mk (person.mk (some 12) none none person nil))
                                                    (new_container person))

      record kv :=
                (get:    Π (t: iterator), iterator → proto)
                (put:    Π (t: iterator), iterator → proto)
                (index : Π (t: iterator), iterator → proto)

         end storage
