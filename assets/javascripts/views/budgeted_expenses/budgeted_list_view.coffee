window.BudgetedListView = Backbone.View.extend
  tagName: 'tbody'
  form: $("#add_budgeted_expense")
  events: 
    'submit #add_budgeted_expense': 'addBudgetExpense'

  initialize: ->
    _.bindAll(@, 'render', 'addBudgetExpense', 'appendBudgetExpense')
    @collection = new BudgetedExpenseList()
    @collection.bind('add', @appendBudgetExpense)

  render: ->
    _(@collection.models).each ((budgetExpense) ->
      appendBudgetExpense budgetExpense
    ), @
    @el

  addBudgetExpense: (data) ->
    budgetedExpense = new BudgetedExpense(
      amount: @form.find(".amount").val()
      description: $("#add_budgeted_expense .description").val()
      payee: $("#add_budgeted_expense .payee").val()
      timing: $("#add_budgeted_expense .timing").val()
    )
    @form[0].reset()
    @collection.add budgetedExpense

  appendBudgetExpense: (budgetedExpense) ->
    budgetedSingleView = new BudgetedSingleView(model: budgetedExpense)
    $(@el).append budgetedSingleView.render().el