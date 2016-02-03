angular.module('app').factory 'main_helper',  ($window) ->

  result = {}

  #
  # Workers list :  preview worker data in sidenav - we need to form data to broadcast it to main controller
  #
  result.worker_data = (worker, job) ->
    json =
      name: worker.name
      job: job.name
      avatar: worker.avatar
      params: []
    for i in job.params
      parameter = i
      parameter.value = worker.values[i.id]
      switch i.type
        when 'file'
          parameter.actions =
            open: (url) ->
              $window.open(url)
              return false
        when 'date'
          if parameter.value
            parameter.value = new Date(parameter.value)
        when 'gallery'

          i.index = 0
          if !i.value
            item.value = []

          i.current = i.value[i.index]
          i.max = i.value.length

          i.next =  (item) ->
            item.index++
            item.current = item.value[item.index]
          i.prev = (item) ->
            item.index--
            item.current = item.value[item.index]

      json.params.push(parameter)
    return json
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


  #
  # Workers - list
  #
  result.configure_params_workers = (params, search, job, ext_search_params) ->

    is_ext = false

    for i in ext_search_params
      if i.value
        is_ext = true;
        break;


    json = {}
    json.limit = params.limit
    json.skip = (params.index_page-1) * json.limit

    json.where = {}

    if is_ext
      json.where = {}
      for i in ext_search_params
        if i.value

          if !i.compare
            json.where['values.'+i.id]  = i.value
            if i.type == 'string' or i.type == 'text'
              json.where['values.'+i.id] = {'contains': i.value}
          else

            if i.compare_value.value == '='
              json.where['values.'+i.id]  = i.value
            else
              json.where['values.'+i.id] = {}
              json.where['values.'+i.id][i.compare_value.value] = i.value
    else
      json.where.name = {'contains' : search} if search
      if (job) and !search
        json.where.job = job if job




    if params.sort[0] == '-'
      json.sort = params.sort.substr(1) + ' desc'
    else
      json.sort = params.sort + ' asc'

    return json


  #
  # Jobs - list
  #
  result.configure_params_jobs = (params, search) ->

    ans = {}
    ans.limit = params.limit
    ans.skip = (params.index_page-1) * ans.limit

    ans.where = {'name': {'contains' : search}} if search

    if params.sort[0] == '-'
      ans.sort = params.sort.substr(1) + ' desc'
    else
      ans.sort = params.sort + ' asc'

    return ans


  #
  # Workers - request maximum results parameters
  #
  result.counter_params = (name_query, selected_job, ext_search_params) ->
    json = {}
    is_ext = false

    for i in ext_search_params
      if i.value
        is_ext = true;
        break;

    if is_ext
      json.querybig = {}
      json.querybig.where = {}
      for i in ext_search_params
        if i.value

          if !i.compare
            json.querybig.where['values.'+i.id]  = i.value
          else

            if i.compare_value.value == '='
              json.querybig.where['values.'+i.id]  = i.value
            else
              json.querybig.where['values.'+i.id] = {}
              json.querybig.where['values.'+i.id][i.compare_value.value] = i.value
    else
      if name_query
        json.query = name_query
      else
        json.id = selected_job
    return json

  #
  # Workers - Editor
  #
  result.is_save_disabled = (worker) ->
    a = false

    # Check if there is a loading state
    if worker.parameters
      for i in worker.parameters
        if i.value
          if i.value.loading
            a = true;
            break;

    # Check if avatar is loading
    a = true if worker.avatar.loading
    a = true if worker.saving_process

    # Check if worker name too short
    if !worker.name
      a = true
    else
      a = true if worker.name.length <3
    return a


  return result
