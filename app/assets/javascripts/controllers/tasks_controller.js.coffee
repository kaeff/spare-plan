root = global ? window
thisApp = root.thisApp

TasksIndexCtrl = thisApp.controller "TasksIndexCtrl", ['$scope', '$routeParams', 'Task', ($scope, $routeParams, Task) ->
  $scope.tasks = Task.query $routeParams

  $scope.destroy = ->
    if confirm("Are you sure?")
      original = @task
      @task.destroy ->
        $scope.tasks = _.without($scope.tasks, original)

  $scope.add = ->
    $scope.tasks.push new Task()

  $scope.save= (task) ->
    if task.id? then task.$update($routeParams, $scope.afterSave) else task.$save($routeParams, $scope.afterSave)

  $scope.afterSave = (task) ->
    Task.query $routeParams, (newTasks) ->
      _.each newTasks, (newTask) ->
        oldTask = _.find($scope.tasks, (t) -> t.id == newTask.id )
        if oldTask
          _.extend oldTask, _.pick(newTask, "early_start", "early_end", "late_start", "late_end", "free_buffer", "total_buffer", "on_critical_path?")
        else
          $scope.tasks.push newTask


  $scope.delete = (task) ->
    $scope.tasks = _.without($scope.tasks, task)
    task.$remove(angular.extend($routeParams, { id: task.id}))
]
