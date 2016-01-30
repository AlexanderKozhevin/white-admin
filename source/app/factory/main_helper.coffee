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

  result.configure_params = (params, search) ->

    ans = {}
    ans.limit = params.limit
    ans.skip = (params.index_page-1) * ans.limit

    ans.where = {'name': {'contains' : search}} if search
    if params.sort[0] == '-'
      ans.sort = params.sort.substr(1) + ' desc'
    else
      ans.sort = params.sort + ' asc'

    return ans

  result.is_save_disabled = (worker) ->
    a = false
    if worker.parameters
      for i in worker.parameters
        if i.value
          if i.value.loading
            a = true;
            break;
            
    a = true if worker.avatar.loading

    if !worker.name
      a = true
    else
      a = true if worker.name.length <3
    return a


  return result
