root = global ? window

angular.module("spareplan.resources.task", []).factory "Task", ['$resource', ($resource) ->
  task = $resource("/tasks/:id",
    id: "@id"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  task::destroy = (cb) ->
    task.remove
      id: @id
    , cb

  task
]
