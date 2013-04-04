
root = global ? window

ProjectsIndexCtrl = ($scope, Project) ->
  $scope.projects = Project.query()

  $scope.destroy = ->
    if confirm("Are you sure?")
      original = @project
      @project.destroy ->
        $scope.projects = _.without($scope.projects, original)
        
ProjectsIndexCtrl.$inject = ['$scope', 'Project'];

ProjectsCreateCtrl = ($scope, $location, Project) ->
  $scope.save = ->
    Project.save $scope.project, (project) ->
      $location.path "/projects/#{project.id}/edit"

ProjectsCreateCtrl.$inject = ['$scope', '$location', 'Project'];

ProjectsShowCtrl = ($scope, $location, $routeParams, Project) ->
  Project.get
    id: $routeParams.id
  , (project) ->
    @original = project
    $scope.project = new Project(@original)

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.project.destroy ->
        $location.path "/projects"

ProjectsShowCtrl.$inject = ['$scope', '$location', '$routeParams', 'Project'];

ProjectsEditCtrl = ($scope, $location, $routeParams, Project) ->
  Project.get
    id: $routeParams.id
  , (project) ->
    @original = project
    $scope.project = new Project(@original)

  $scope.isClean = ->
    console.log "[ProjectsEditCtrl, $scope.isClean]"
    angular.equals @original, $scope.project

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.project.destroy ->
        $location.path "/projects"

  $scope.save = ->
    Project.update $scope.project, (project) ->
      $location.path "/projects"

ProjectsEditCtrl.$inject = ['$scope', '$location', '$routeParams', 'Project'];

# exports
root.ProjectsIndexCtrl  = ProjectsIndexCtrl
root.ProjectsCreateCtrl = ProjectsCreateCtrl
root.ProjectsShowCtrl   = ProjectsShowCtrl
root.ProjectsEditCtrl   = ProjectsEditCtrl 