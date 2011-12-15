# Responsible for table sorting

window.App.StatsView = Backbone.View.extend
  tagName: 'section'
  className: 'stats group'

  initialize: ->
    _.bindAll(@, 'render', 'updateStats')
    @stats = new App.Stats()
    @stats.bind('change', this.render)
    
    @budgetedExpenses = App.BudgetedExpenses
    @budgetedExpenses.fetch()
    @budgetedExpenses.bind('add', @updateStats)
    @budgetedExpenses.bind('change', @updateStats)
    @budgetedExpenses.bind('remove', @updateStats)

    @incomes = App.Incomes
    @incomes.fetch()
    @incomes.bind('add', @updateStats)
    @incomes.bind('change', @updateStats)
    @incomes.bind('remove', @updateStats)

  render: ->
    @updateStats()
    $(@el).html(@template(@stats.toJSON()))
    $(@el).find('.currency').formatCurrency()
    @el

  template: ->
    template = _.template($("#stats_template").text())
    template.apply(@, arguments)

  updateStats: ->
    @stats.set(
      cashFlow: @cashFlow()
      spending: @spending()
      income: @income()
      savings: 8 
    )

  cashFlow: ->
    @income() + @spending()
  
  spending: ->
    @total_for(@budgetedExpenses.models) * -1

  income: ->
    @total_for(@incomes.models)

  class_for_amount: (amount) ->
    if amount >= 0
      "green"
    else
      "red"

  total_for: (collection) ->
    _.reduce(collection, (sum, budgeted_expense) ->
      num = parseFloat(budgeted_expense.toJSON().amount)
      if(isNaN(num))
        num = 0
      num + sum
    , 0)