# Responsible for table sorting

window.App.BudgetedTableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'click #add_budgeted_expense': 'addBudgetExpense'
    'click #add_budget_expense': 'showForm'
    'click #add_budgeted_expense_wrapper .hide': 'hideForm'
    'keyup #add_budgeted_expense_wrapper input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'addBudgetExpense', 'appendBudgetExpense')
    @collection = App.BudgetedExpenses
    @collection.bind('add', @appendBudgetExpense)

  render: ->
    $(@el).append(@template())
    @collection.fetch()
    _(@collection.models).each ((budgetExpense) ->
      @appendBudgetExpense budgetExpense
    ), @
    @el

  template: ->
    template = _.template($("#budgeted_template").text());
    template.apply(@, arguments);

  checkForSubmit: (e) ->
    @addBudgetExpense() if e.keyCode == 13

  addBudgetExpense: ->
    form = $(@el).find("#add_budgeted_expense_wrapper")
    @collection.create(
      description: form.find(".description").val()
      payee: form.find(".payee").val()
      amount: form.find(".amount").val()
      timing: form.find(".timing").val()
    )
    @clearForm()
    form.find(".description").focus()

  appendBudgetExpense: (budgetedExpense) ->
    budgetedSingleView = new App.BudgetedSingleView(model: budgetedExpense)
    $(@el).find("tbody#budgeted_expenses_body").append budgetedSingleView.render().el

  clearForm: ->
    $("#add_budgeted_expense_wrapper input[type='text']").val("")

  showForm: ->
    $("#add_budgeted_expense_wrapper").show()

  hideForm: ->
    @clearForm()
    $("#add_budgeted_expense_wrapper").hide()