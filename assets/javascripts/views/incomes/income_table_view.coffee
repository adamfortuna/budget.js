# Responsible for table sorting

window.App.IncomeTableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'click #add_income': 'addIncome'
    'click #show_form': 'showForm'
    'click #add_incomew_wrapper .hide': 'hideForm'
    'keyup #add_income_wrapper input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'addIncome', 'appendIncome')
    @collection = App.Incomes
    @collection.bind('add', @appendIncome)

  render: ->
    $(@el).append(@template())
    @collection.fetch()
    _(@collection.models).each ((income) ->
      @appendIncome income
    ), @
    @el

  template: ->
    template = _.template($("#income_template").text());
    template.apply(@, arguments);

  checkForSubmit: (e) ->
    @addIncome() if e.keyCode == 13

  addIncome: ->
    form = $(@el).find("#add_income_wrapper")
    @collection.create(
      description: form.find(".description").val()
      payee: form.find(".payee").val()
      amount: form.find(".amount").val()
      timing: form.find(".timing").val()
    )
    @clearForm()
    form.find(".description").focus()

  appendIncome: (income) ->
    incomeSingleView = new App.IncomeSingleView(model: income)
    $(@el).find("tbody#income_body").append incomeSingleView.render().el

  clearForm: ->
    $("#add_income_wrapper input[type='text']").val("")

  showForm: ->
    $("#add_income_wrapper").show()

  hideForm: ->
    @clearForm()
    $("#add_income_wrapper").hide()