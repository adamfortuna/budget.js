window.App.Expense = Backbone.Model.extend
  weekly_amount: ->
    @amount * 12 / 52

  daily_amount: ->
    @amount * 12 / 365
    
window.App.BudgetedExpense = window.App.Expense.extend
  initialize: ()->