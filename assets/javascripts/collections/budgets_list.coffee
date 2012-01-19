window.App.BudgetsList = App.AccountingList.extend
  localStorage: new Store('budgets_list')
  model: App.Budget
window.App.Budgets = new App.BudgetsList()