window.App.Populate = Backbone.Model.extend
  run: ->
    @populate(App.Budgets, @budgetSeeds())
    @populate(App.Incomes, @incomeSeeds())
    @populate(App.BudgetedExpenses, @billSeeds())
    @populate(App.Savings, @savingsSeeds())

  populate: (collectionClass, seeds) ->
    collectionClass.fetch()
    collectionClass.reset()
    newRows = _.map seeds, (seed) ->
      collectionClass.create(seed)
  
  billSeeds: ->
    [
      amount: 1200.00
      description: "Mortgage"
      timing: "Monthly"
    ,
      amount: 100.00
      description: "Cable Bill"
      timing: "Monthly"
    ,
      amount: 150.00
      description: "Power Bill"
      timing: "Monthly"
    ,
      amount: 10.00
      description: "Water Bill"
      timing: "Monthly"
    ,
      amount: 80.00
      description: "Car Insurance"
      timing: "Monthly"
    ,
      amount: 90
      description: "Cell Phone Bill"
      timing: "Monthly"
    ,
      amount: 8.62
      description: "Netflix"
      timing: "Monthly"      
    ]

  budgetSeeds: ->
    [
      amount: 250,
      description: 'Groceries',
      payee: 'Various',
      timing: 'Monthly'
    ,
      amount: 250,
      description: 'Dining Out',
      payee: 'Various',
      timing: 'Monthly'
    ,
      amount: 80,
      description: 'Gas',
      payee: 'Various',
      timing: 'Monthly'
    ,
      amount: 300,
      description: 'Books and Education',
      payee: 'Various',
      timing: 'Yearly'
    ,
      amount: 500,
      description: 'Furniture',
      payee: 'Various',
      timing: 'Yearly'
    ,
      amount: 300,
      description: 'Gifts',
      payee: 'Various',
      timing: 'Yearly'
    ,
      amount: 500,
      description: 'Charity',
      payee: 'Various',
      timing: 'Yearly'
    ,
      amount: 20,
      description: 'Medical Expenses',
      payee: 'Various',
      timing: 'Monthly'
    ,
      amount: 40,
      description: 'Pets',
      payee: 'Various',
      timing: 'Monthly'
    ]

  incomeSeeds: ->
    [
      amount: 4000.00
      description: "Paycheck"
      payee: "Me"
      timing: "Monthly"
    ,
      amount: 15500.00
      description: "Pre-tax 401K"
      payee: "Me"
      timing: "yearly"
    ]
  
  savingsSeeds: ->
    [
      amount: 5000.00
      description: "Roth IRA"
      timing: "Yearly"
    ,
      amount: 5000.00
      description: "General Investments"
      timing: "Yearly"
    ,
      amount: 15500.00
      description: "401K"
      timing: "Yearly"
    ]