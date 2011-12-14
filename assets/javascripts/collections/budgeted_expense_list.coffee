window.App.BudgetedExpenseList = Backbone.Collection.extend
  localStorage: new Store('budgeted_expense_list')
  model: App.BudgetedExpense
window.App.BudgetedExpenses = new App.BudgetedExpenseList