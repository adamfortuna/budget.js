window.App.ApplicationController = Backbone.Router.extend
  routes:
    '': 'budgeted'
    'overview': 'overview'
    'savings': 'savings'
    'budgeted': 'budgeted'
    'expenses': 'expenses'
    'history': 'history'
    'income': 'income'

  budgeted: ->
    view = new App.BudgetedTableView()
    $("#main > section").remove()
    $("#main").append(view.render())
    $('.datatable').dataTable(
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "sDom": '<""f>t<"F"lp>'
    )
  
  income: ->
    view = new App.IncomeTableView()
    $("#main > section").remove()
    $("#main").append(view.render())
    $('.datatable').dataTable(
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "sDom": '<""f>t<"F"lp>'
    )

  overview: ->
    @tab('overview', 'overview')
  
  savings: ->
    @tab('savings', 'savings')

  expenses: ->
    @tab('expenses', 'expenses')
    
  history: ->
    @tab('history', 'history')
  
  tab: (page, content) ->
    $("#main > div").remove()
    $("#" + page).show()

$ ->
  new App.ApplicationController()
  new App.StatsView()
  Backbone.history.start()