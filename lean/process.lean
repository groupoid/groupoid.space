
      import data.nat data.bool data.prod data.list data.sum data.stream
             data.unit data.uprod data.tuple data.option application persistence
        open nat bool prod sum list classical option stream application persistence
   namespace process

      record task      := (name: string)
      record event     := (name: string)
      record flow      := (source: task) (target: task)
      record process extends iterator :=
             (env: list iterator)
             (feed_id: ℕ)
             (taxonomy: prod (prod (list task) (list flow)) (list event))

      record proc extends app proto process :=
             (sup: list process)

        eval proc

         end process
