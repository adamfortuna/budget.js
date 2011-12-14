window.App.IncomeTableView = App.TableView.extend
  collectionClass: App.Incomes
  rowClass: App.IncomeSingleView
  templateElement: "#income_template"