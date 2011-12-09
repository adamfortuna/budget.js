window.BudgetedExpenseList = Backbone.Collection.extend
  model: BudgetedExpense
  localStorage: new Store('budgeted_expense_list')