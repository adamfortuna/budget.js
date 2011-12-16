window.App.ApplicationController = Backbone.Router.extend
  routes:
    '': 'overview'
    'overview': 'overview'
    'savings': 'savings'
    'budgeted': 'budgeted'
    'expenses': 'expenses'
    'history': 'history'
    'income': 'income'

  overview: ->
    stats = new App.StatsView()
    $("#main").empty().append(stats.render())

  income: ->
    view = new App.IncomeTableView()
    $("#main").empty().append(view.render())

  budgeted: ->
    view = new App.BudgetedTableView()
    $("#main").empty().append(view.render())
  
  savings: ->
    savings = new App.SavingTableView()
    $("#main").empty().append(savings.render())

  expenses: ->
    @tab('expenses', 'expenses')
    
  history: ->
    @tab('history', 'history')
  
  tab: (page, content) ->
    $("#main > div").remove()
    $("#" + page).show()

$ ->
  new App.ApplicationController()
  Backbone.history.start()