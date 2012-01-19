window.App.BudgetSingleView = App.SingleView.extend
  templateElement: "#saving_budget_row_template"
  
  parseAttributes: ->
    description: $(@el).find(".description").val()
    timing: $(@el).find(".timing").val()
    amount: $(@el).find(".amount").val()