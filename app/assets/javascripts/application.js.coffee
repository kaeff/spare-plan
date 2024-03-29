#
## External dependencies - (Should be) provided by package manager
#
#= require vendor
#
## Internal dependencies - (Should be) provided by module loader
#
#= require dumose/resources
#= require_tree ./directives
# (Templates need to go last)
#= require_tree ../templates
#
## Initialization
#
#= require_self
#= require_tree ./controllers
#= require routes

root = global ? window
root.thisApp = angular.module("SparePlanClient", ['ngCookies', 'spareplan.resources', 'directives'])
