window.App.SavingTableView = App.TableView.extend
  collectionClass: App.Savings
  rowClass: App.SavingSingleView
  modelClass: App.Saving
  templateElement: "#savings_template"
  
  parseAttributes: ->
    form = $(@el).find(".new_row_template")
      
    description: form.find(".description").val()
    amount: form.find(".amount").val()
    timing: form.find(".timing").val()