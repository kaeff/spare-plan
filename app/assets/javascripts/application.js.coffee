#
## External dependencies - (Should be) provided by package manager
#
#= require vendor
#
## Internal dependencies - (Should be) provided by module loader
#
#= require_tree ./resources
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
angular.module 'spareplan.resources', ['ngResource', 'spareplan.resources.project', 'spareplan.resources.task', 'spareplan.resources.project']
root.thisApp = angular.module("SparePlanClient", ['ngCookies', 'spareplan.resources', 'directives'])
