window.App.BudgetedExpense = App.Accounting.extend
  defaults:
    'amount': 0
    'description': null
    'payee': null
    'timing': 'Monthly'

  validate: (attributes) ->
    errors = []

    if !attributes.amount || attributes.amount.length == 0
      errors.push(
        'field': 'amount'
        'message': 'cannot be empty'
      )
    else if isNaN(attributes.amount)
      errors.push(
        'field': 'amount'
        'message': 'must be a number'
      )
    
    if !attributes.description || attributes.description.length == 0
      errors.push(
        'field': 'description'
        'message': 'cannot be empty'
      )

    if !attributes.payee || attributes.payee.length == 0
      errors.push(
        'field': 'payee'
        'message': 'cannot be empty'
      )

    if !attributes.timing || attributes.timing.length == 0
      errors.push(
        'field': 'timing'
        'message': 'cannot be empty'
      )

    return errors if errors.length > 0
