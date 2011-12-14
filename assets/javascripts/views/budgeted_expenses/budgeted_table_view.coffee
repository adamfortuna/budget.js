window.App.BudgetedTableView = App.TableView.extend
  collectionClass: App.BudgetedExpenses
  rowClass: App.BudgetedSingleView
  templateElement: "#budgeted_template"