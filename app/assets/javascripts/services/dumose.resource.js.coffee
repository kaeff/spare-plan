angular.module('dumose.resource', ['ngResource']).factory 'rails-resource', ['$resource', ($resource) ->
  Resouce = $resource("/projects/:id",
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
