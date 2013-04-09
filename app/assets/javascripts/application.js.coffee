#
## External dependencies
#
#= require vendor
#
## Internal dependencies
#
#= require_tree ./resources
#= require_tree ../templates
#
## Initialization
#
#= require_self
#= require_tree ./controllers
#= require routes

root = global ? window
root.thisApp = angular.module("SparePlanClient", ['ngCookies', 'resources'])
