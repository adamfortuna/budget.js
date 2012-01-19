window.App.ExpenseList = App.AccountingList.extend
  localStorage: new Store('expense_list')
  model: App.Expense

window.App.Expenses = new App.ExpenseList()