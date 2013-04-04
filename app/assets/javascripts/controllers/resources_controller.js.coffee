root = global ? window
thisApp = root.thisApp

ResourcesIndexCtrl = thisApp.controller "ResourcesIndexCtrl",  ($scope, Resource) ->
  $scope.resources = Resource.query()

  $scope.destroy = ->
    if confirm("Are you sure?")
      original = @resource
      @resource.destroy ->
        $scope.resources = _.without($scope.resources, original)
ResourcesIndexCtrl.$inject = ['$scope', 'Resource']

ResourcesCreateCtrl = thisApp.controller "ResourcesCreateCtrl", ($scope, $location, Resource) ->
  $scope.save = ->
    Resource.save $scope.resource, (resource) ->
      $location.path "/resources/#{resource.id}/edit"

ResourcesCreateCtrl.$inject = ['$scope', '$location', 'Resource']

ResourcesShowCtrl = thisApp.controller "ResourcesShowCtrl", ($scope, $location, $routeParams, Resource) ->
  Resource.get
    id: $routeParams.id
  , (resource) ->
    @original = resource
    $scope.resource = new Resource(@original)

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.resource.destroy ->
        $location.path "/resources"

ResourcesShowCtrl.$inject = ['$scope', '$location', '$routeParams', 'Resource']

ResourcesEditCtrl = thisApp.controller "ResourcesEditCtrl", ($scope, $location, $routeParams, Resource) ->
  Resource.get
    id: $routeParams.id
  , (resource) ->
    @original = resource
    $scope.resource = new Resource(@original)

  $scope.isClean = ->
    console.log "[ResourcesEditCtrl, $scope.isClean]"
    angular.equals @original, $scope.resource

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.resource.destroy ->
        $location.path "/resources"

  $scope.save = ->
    Resource.update $scope.resource, (resource) ->
      $location.path "/resources"

ResourcesEditCtrl.$inject = ['$scope', '$location', '$routeParams', 'Resource']
