root = global ? window
thisApp = root.thisApp

TasksIndexCtrl = thisApp.controller "TasksIndexCtrl", ($scope, Task) ->
  $scope.tasks = Task.query()

  $scope.destroy = ->
    if confirm("Are you sure?")
      original = @task
      @task.destroy ->
        $scope.tasks = _.without($scope.tasks, original)

  $scope.add = ->
    $scope.tasks.push new Task()

  $scope.save= (task) ->
    if task.id? then task.$update() else task.$save()

  $scope.delete = (task) ->
    $scope.tasks.splice $scope.tasks.indexOf(task), 1
    task.$remove()

