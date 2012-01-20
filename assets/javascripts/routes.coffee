window.App.ApplicationController = Backbone.Router.extend
  routes:
    '': 'overview'
    'overview': 'overview'
    'budgets': 'budgets'
    'savings': 'savings'
    'budgeted': 'budgeted'
    'expenses': 'expenses'
    'history': 'history'
    'income': 'income'
    'populate': 'populate'

  overview: ->
    stats = new App.StatsView()
    $("#main").empty().append(stats.render())

  budgets: ->
    budgets = new App.BudgetTableView()
    $("#main").empty().append(budgets.render())
    
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
    expenses = new App.ExpenseTableView()
    $("#main").empty().append(expenses.render())
    
  populate: ->
    populate = new App.Populate()
    populate.run()
    alert("Data populated!")

  history: ->
    @tab('history', 'history')
  
  tab: (page, content) ->
    $("#main > div").remove()
    $("#" + page).show()

$ ->
  new App.ApplicationController()
  Backbone.history.start()