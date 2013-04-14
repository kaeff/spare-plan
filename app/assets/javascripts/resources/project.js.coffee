root = global ? window

angular.module("spareplan.resources.project", []).factory "Project", ['$resource', ($resource) ->
  Project = $resource("/projects/:id",
    id: "@id"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  Project::destroy = (cb) ->
    Project.remove
      id: @id
    , cb

  Project
]
root.angular = angular
