# Responsible for table sorting

window.App.StatsView = Backbone.View.extend
  tagName: 'section'

  initialize: ->
    _.bindAll(@, 'render', 'recalculateTotals')
    @budgetedExpenses = App.BudgetedExpenses
    @budgetedExpenses.bind('add', @recalculateTotals)
    @budgetedExpenses.bind('change', @recalculateTotals)
    @budgetedExpenses.bind('remove', @recalculateTotals)

    @incomes = App.Incomes
    @incomes.bind('add', @recalculateTotals)
    @incomes.bind('change', @recalculateTotals)
    @incomes.bind('remove', @recalculateTotals)
    @render()

  render: ->
    @budgetedExpenses.fetch()
    @incomes.fetch()
    $(@el).addClass("stats").addClass("group").append(@template(
      monthly_cash_flow: ""
      spending: ""
      income: ""
    ))
    $(".content").prepend($(@el))
    @recalculateTotals()
  
  template: ->
    template = _.template($("#stats_template").text());
    template.apply(@, arguments);

  recalculateTotals: ->
    cash_flow = @cash_flow()
    spending = @spending()
    income = @income()
    $("#stats_cash_flow, #stats_spending, #stats_income").removeClass("green").removeClass("red")
    $("#stats_cash_flow").html(cash_flow).addClass(@class_for_amount(cash_flow)).formatCurrency()
    $("#stats_spending").html(spending).addClass(@class_for_amount(spending)).formatCurrency()
    $("#stats_income").html(income).addClass(@class_for_amount(income)).formatCurrency()

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