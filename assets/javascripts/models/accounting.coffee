window.App.Accounting = Backbone.Model.extend
  monthlyAmount: ->
    if @.attributes.timing == 'Yearly'
      @.attributes.amount / 12
    else
      @.attributes.amount

  yearlyAmount: ->
    @monthlyAmount * 12

  weeklyAmount: ->
    @yearlyAmount / 52

  dailyAmount: ->
    @yearlyAmount / 365
