angular.module('app').factory 'main_helper',  () ->

  result = {}
  result.select_active_tab = (state) ->
    index = 0
    if state.indexOf('workers') != -1
      index = 0
    if state.indexOf('jobs') != -1
      index = 1
    if state.indexOf('stat') != -1
      index = 2
    return index

  result.is_new = (state) ->
    if state.indexOf('list') != -1
      return true
    else
      return false
  return result
