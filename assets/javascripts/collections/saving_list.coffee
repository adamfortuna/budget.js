window.App.SavingsList = Backbone.Collection.extend
  localStorage: new Store('savings_list')
  model: App.Saving
window.App.Savings = new App.SavingsList()