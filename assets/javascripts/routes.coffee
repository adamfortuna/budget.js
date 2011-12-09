window.ApplicationController = Backbone.Router.extend
  routes:
    '': 'budgeted'
    'overview': 'overview'
    'savings': 'savings'
    'budgeted': 'budgeted'
    'expenses': 'expenses'
    'history': 'history'

  budgeted: ->
    view = new BudgetedListView()
    @tab('budgeted', view.render().el)

  overview: ->
    @tab('overview', 'overview')
  
  savings: ->
    @tab('savings', 'savings')

  expenses: ->
    @tab('expenses', 'expenses')
    
  history: ->
    @tab('history', 'history')
  
  tab: (page, content) ->
    $("#main > div").hide()
    $("#" + page).show().html(content)

$ ->
  new ApplicationController()
  Backbone.history.start()