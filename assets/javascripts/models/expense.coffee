window.Expense = Backbone.Model.extend
  weekly_amount: ->
    @amount * 12 / 52

  daily_amount: ->
    @amount * 12 / 365 
    
window.BudgetedExpense = window.Expense.extend
  initialize: ()->