# Responsible for table sorting

window.App.StatsView = Backbone.View.extend
  tagName: 'section'
  className: 'stats group'

  initialize: ->
    _.bindAll(@, 'render', 'updateStats')
    @stats = new App.Stats()
    @stats.bind('change', this.render)
    
    @budgetedExpenses = App.BudgetedExpenses
    @budgetedExpenses.bind('add', @updateStats)
    @budgetedExpenses.bind('change', @updateStats)
    @budgetedExpenses.bind('remove', @updateStats)

    @incomes = App.Incomes
    @incomes.bind('add', @updateStats)
    @incomes.bind('change', @updateStats)
    @incomes.bind('remove', @updateStats)

  render: ->
    @budgetedExpenses.fetch()
    @incomes.fetch()
    @updateStats()
    $(@el).html(@template(@stats.toJSON()))
    @el

  template: ->
    template = _.template($("#stats_template").text())
    template.apply(@, arguments)

  updateStats: ->
    @stats.set(
      cash_flow: @cash_flow()
      spending: @spending()
      income: @income()
      savings: 0
    )

  cash_flow: ->
    @income() + @spending()
  
  spending: ->
    _.reduce(@budgetedExpenses.models, (sum, budgeted_expense) ->
      parseFloat(budgeted_expense.toJSON().amount) + sum
    , 0) * -1

  income: ->
    _.reduce(@incomes.models, (sum, income) ->
      parseFloat(income.toJSON().amount) + sum
    , 0)
    
  class_for_amount: (amount) ->
    if amount >= 0
      "green"
    else
      "red"