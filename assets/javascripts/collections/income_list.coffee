window.App.IncomeList = Backbone.Collection.extend
  localStorage: new Store('income_list')
  model: Income
window.App.Incomes = new App.IncomeList