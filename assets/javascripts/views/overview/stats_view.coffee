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
    
    @budgets = App.Budgets
    @budgets.fetch()

    @incomes = App.Incomes
    @incomes.fetch()

    @savings = App.Savings
    @savings.fetch()

  render: ->
    @updateStats()
    $(@el).html(@template(@stats.toJSON()))
    $(@el).find('.currency').formatCurrency()
    # $(@el).find('.percentage').formatNumber({ format: "#.0%", locale: "us" });
    @el

  template: ->
    template = _.template($("#stats_template").text())
    template.apply(@, arguments)

  updateStats: ->
    @stats.set(
      monthly:
        cashFlow: @incomes.monthlyTotal() - @savings.monthlyTotal() - @budgetedExpenses.monthlyTotal() - @budgets.monthlyTotal()
        bills: @budgetedExpenses.monthlyTotal()
        budgets: @budgets.monthlyTotal()
        income: @incomes.monthlyTotal()
        savings: @savings.monthlyTotal()
      yearly:
        cashFlow: @incomes.yearlyTotal() - @savings.yearlyTotal() - @budgetedExpenses.yearlyTotal() - @budgets.yearlyTotal()
        bills: @budgetedExpenses.yearlyTotal()
        budgets: @budgets.yearlyTotal()
        income: @incomes.yearlyTotal()
        savings: @savings.yearlyTotal()
      daily:
        cashFlow: @incomes.dailyTotal() - @savings.dailyTotal() - @budgetedExpenses.dailyTotal() - @budgets.dailyTotal()
        bills: @budgetedExpenses.dailyTotal()
        budgets: @budgets.dailyTotal()
        income: @incomes.dailyTotal()
        savings: @savings.dailyTotal()
      rate:
        cashFlow: @to_percent((@incomes.monthlyTotal() - @savings.monthlyTotal() - @budgetedExpenses.monthlyTotal() - @budgets.monthlyTotal()) / @incomes.monthlyTotal())
        bills: @to_percent(@budgetedExpenses.monthlyTotal() / @incomes.monthlyTotal())
        budgets: @to_percent(@budgets.monthlyTotal() / @incomes.monthlyTotal())
        income: @to_percent(1)
        savings: @to_percent(@savings.monthlyTotal() / @incomes.monthlyTotal())
    )
    
  to_percent: (number) -> 
    (number * 100).toFixed(2) + "%"