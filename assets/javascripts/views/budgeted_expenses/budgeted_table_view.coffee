# Responsible for table sorting

window.App.BudgetedTableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'submit #add_budgeted_expense': 'addBudgetExpense'

  initialize: ->
    _.bindAll(@, 'render', 'addBudgetExpense', 'appendBudgetExpense')
    @collection = App.BudgetedExpenses
    @collection.bind('add', @appendBudgetExpense)

  render: ->
    $(@el).append(@template())
    console.log(@collection.models)
    @collection.fetch()
    _(@collection.models).each ((budgetExpense) ->
      @appendBudgetExpense budgetExpense
    ), @
    @el
  
  template: ->
    template = _.template($("#budgeted_template").text());
    template.apply(@, arguments);

  addBudgetExpense: (data) ->
    form = $(@el).find("form")
    # budgetedExpense = new BudgetedExpense(
    #   amount: form.find(".amount").val()
    #   description: form.find(".description").val()
    #   payee: form.find(".payee").val()
    #   timing: form.find(".timing").val()
    # )
    # @collection.add budgetedExpense

    @collection.create(
      amount: form.find(".amount").val()
      description: form.find(".description").val()
      payee: form.find(".payee").val()
      timing: form.find(".timing").val()
    )
    form[0].reset()
    

  appendBudgetExpense: (budgetedExpense) ->
    budgetedSingleView = new App.BudgetedSingleView(model: budgetedExpense)
    $(@el).find("tbody#budgeted_expenses_body").prepend budgetedSingleView.render().el