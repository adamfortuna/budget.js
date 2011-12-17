# Responsible for table sorting

window.App.StatsView = Backbone.View.extend
  tagName: 'section'
  className: 'stats group'

  initialize: ->
    _.bindAll(@, 'render', 'updateStats')
    @stats = new App.Stats()
    @stats.bind('change', @render)

    @budgetedExpenses = App.BudgetedExpenses
    @budgetedExpenses.fetch()

    @incomes = App.Incomes
    @incomes.fetch()

    @savings = App.Savings
    @savings.fetch()

  render: ->
    console.log("render")
    console.log(@stats.toJSON())
    @updateStats()
    $(@el).html(@template(@stats.toJSON()))
    $(@el).find('.currency').formatCurrency()
    @el

  template: ->
    template = _.template($("#stats_template").text())
    template.apply(@, arguments)

  updateStats: ->
    console.log("updating stats")
    @stats.set(
      monthly:
        cashFlow: @incomes.monthlyTotal() - @savings.monthlyTotal() - @budgetedExpenses.monthlyTotal()
        spending: @budgetedExpenses.monthlyTotal()
        income: @incomes.monthlyTotal()
        savings: @savings.monthlyTotal()
      yearly:
        cashFlow: @incomes.yearlyTotal() - @savings.yearlyTotal() - @budgetedExpenses.yearlyTotal()
        spending: @budgetedExpenses.yearlyTotal()
        income: @incomes.yearlyTotal()
        savings: @savings.yearlyTotal()
      daily:
        cashFlow: @incomes.dailyTotal() - @savings.dailyTotal() - @budgetedExpenses.dailyTotal()
        spending: @budgetedExpenses.dailyTotal()
        income: @incomes.dailyTotal()
        savings: @savings.dailyTotal()
    )