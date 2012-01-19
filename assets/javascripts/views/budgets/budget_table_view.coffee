window.App.BudgetTableView = App.TableView.extend
  collectionClass: App.Budgets
  rowClass: App.BudgetSingleView
  modelClass: App.Budget
  templateElement: "#budgets_template"
  
  parseAttributes: ->
    form = $(@el).find(".new_row_template")

    timing: form.find(".timing").val()
    description: form.find(".description").val()
    amount: form.find(".amount").val()