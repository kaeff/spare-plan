##
# Directive that executes code after a model is finished editing
angular.module("directives", []).directive "spModelEdited", ->
  (scope, elem, attrs) ->
    modelEdited = false
    elem.bind "blur", ->
      execute = modelEdited
      modelEdited = false
      scope.$apply attrs.spModelEdited if execute
    elem.bind "change", ->
      modelEdited  = true
