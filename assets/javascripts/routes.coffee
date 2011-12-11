window.App.ApplicationController = Backbone.Router.extend
  routes:
    '': 'budgeted'
    'overview': 'overview'
    'savings': 'savings'
    'budgeted': 'budgeted'
    'expenses': 'expenses'
    'history': 'history'

  budgeted: ->
    view = new App.BudgetedTableView()
    $("#main > section").remove()
    $("#main").append(view.render())

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
  Backbone.history.start()