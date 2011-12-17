window.App.SavingsList = App.AccountingList.extend
  localStorage: new Store('savings_list')
  model: App.Saving

window.App.Savings = new App.SavingsList()