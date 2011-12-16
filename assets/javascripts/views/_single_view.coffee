window.App.SingleView = Backbone.View.extend
  tagName: 'tr'
  events: 
    'click td span': 'edit'
    'click .delete': 'destroy'
    'click .edit': 'edit'
    'click .update': 'update'
    'click .cancel': 'cancel'
    'keyup input': 'checkForSubmit'

  initialize: ->
    _.bindAll(this, 'render', 'unrender', 'destroy', 'edit', 'update', 'stopEditing', 'cancel', 'checkForSubmit', 'error')
    @model.bind('change', @render)
    @model.bind('remove', @unrender)
    @model.bind('error', @error)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    $(@el).find('.currency').formatCurrency()
    return @

  template: (data) ->
    template = _.template($(@templateElement).text());
    template(data);
  
  unrender: ->
    $(@el).remove()
  
  destroy: ->
    @model.destroy()
  
  edit: ->
    $(@el).parents("table").find('tbody tr').removeClass("editing")
    $(@el).addClass("editing")
  
  checkForSubmit: (e) ->
    if e.keyCode == 13
      @update()
    else if e.keyCode == 27
      @stopEditing()

  stopEditing: ->
    $(@el).removeClass("editing").find(".error").removeClass(".error")
  
  update: ->
    if @model.set(
      amount: $(@el).find(".amount").val()
      description: $(@el).find(".description").val()
      payee: $(@el).find(".payee").val()
      timing: $(@el).find(".timing").val()
    )
      @stopEditing()

  cancel: -> 
    @stopEditing()
  
  error: (model, errors) ->
    $(@el).find(".error").removeClass("error")
    for error in errors
      $(@el).find(".#{error.field}").addClass("error")