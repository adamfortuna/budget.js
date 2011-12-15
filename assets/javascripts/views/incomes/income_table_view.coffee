window.App.IncomeTableView = App.TableView.extend
  collectionClass: App.Incomes
  rowClass: App.IncomeSingleView
  modelClass: App.Income
  templateElement: "#income_template"