window.App.AccountingList = Backbone.Collection.extend
  monthlyTotal: ->    
    _.reduce(@models, (sum, accounting) ->
      num = parseFloat(accounting.monthlyAmount())
      if(isNaN(num))
        num = 0
      num + sum
    , 0)

  yearlyTotal: ->
    @monthlyTotal() * 12
  
  dailyTotal: ->
    @yearlyTotal() / 365