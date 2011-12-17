window.App.IncomeList = App.AccountingList.extend
  localStorage: new Store('income_list')
  model: App.Income
window.App.Incomes = new App.IncomeList()