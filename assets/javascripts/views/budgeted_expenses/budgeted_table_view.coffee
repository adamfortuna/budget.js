window.App.BudgetedTableView = App.TableView.extend
  collectionClass: App.BudgetedExpenses
  rowClass: App.BudgetedSingleView
  modelClass: App.BudgetedExpense
  templateElement: "#budgeted_template"