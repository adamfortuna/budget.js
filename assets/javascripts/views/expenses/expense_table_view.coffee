window.App.ExpenseTableView = App.TableView.extend
  collectionClass: App.Expenses
  rowClass: App.ExpenseSingleView
  modelClass: App.Expense
  templateElement: "#expense_template"

  tagName: 'section'
  events: 
    'click .create': 'create'
    'click .add_new': 'showForm'
    'click .new_row_template .hide': 'hideForm'
    'keyup .new_row_template input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'create', 'appendItem', 'appendItemAndResort', 'checkForSubmit', 'template', 'clearForm', 'showForm', 'hideForm', 'resort', 'error', 'parseAttributes')
    
    @budgetedExpenses = App.BudgetedExpenses
    @budgetedExpenses.fetch()
    @budgetedExpensesNames = @budgetedExpenses.map (budgetedExpense) ->
      budgetedExpense.get('description')

    @budgets = App.Budgets
    @budgets.fetch()
    @budgetNames = @budgets.map (budget) ->
      budget.get('description')

    @collection = @collectionClass
    @collection.fetch()
    @collection.bind('add', @appendItemAndResort)
    @collection.bind('remove', @resort)

  render: ->
    $(@el).append(@template({ "budgets": @budgetNames.sort(), "bills": @budgetedExpensesNames.sort() }))
    _(@collection.models).each ((item) ->
      @appendItem item
    ), @
    @resort()
    @el

  template: ->
    template = _.template($(@templateElement).text());
    template.apply(@, arguments);

  checkForSubmit: (e) ->
    if e.keyCode == 13
      @create()
    else if e.keyCode == 27
      @hideForm()

  appendItemAndResort: (item) ->
    @appendItem item
    @resort()

  appendItem: (item) ->
    newItem = new @rowClass(model: item)
    $(@el).find("tbody").prepend(newItem.render().el)

  clearForm: ->
    $(@el).find(".new_row_template").find(".error").removeClass("error")
    $(@el).find(".new_row_template input[type='text']").val("")

  showForm: ->
    $(@el).find("table tr").removeClass("editing")
    $(@el).addClass("adding").find("input:first").focus()

  hideForm: ->
    @clearForm()
    $(@el).removeClass("adding")
  
  parseAttributes: ->
    form = $(@el).find(".new_row_template")
      
    payee: form.find(".payee").val()
    amount: form.find(".amount").val()
    expense: form.find(".expense").val()

  create: ->
    form = $(@el).find(".new_row_template")
    item = new @modelClass()
    attributes = @parseAttributes()
    errors = item.validate(attributes)
    
    if errors && errors.length > 0
      @error(errors)
    else
      @collection.create(attributes)
      @clearForm()
      form.find("input:first").focus()
  
  resort: ->
    $(@el).find('.datatable').dataTable(
      "bJQueryUI": true
      "sPaginationType": "full_numbers"
      "sDom": '<""f>t<"F"lp>'
    )

  error: (errors) ->
    $(@el).find(".new_row_template .error").removeClass("error")
    for error in errors
      $(@el).find(".new_row_template .#{error.field}").addClass("error")