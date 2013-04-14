root = global ? window

angular.module("spareplan.resources.resource", []).factory "Resource", ['$resource', ($resource) ->
  Resource = $resource("/resources/:id",
    id: "@id"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  Resource::destroy = (cb) ->
    Resource.remove
      id: @id
    , cb

  Resource
]
root.angular = angular
