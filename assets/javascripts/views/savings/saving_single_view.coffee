window.App.SavingSingleView = App.SingleView.extend
  templateElement: "#saving_row_template"
  
  parseAttributes: ->
    amount: $(@el).find(".amount").val()
    description: $(@el).find(".description").val()
    timing: $(@el).find(".timing").val()