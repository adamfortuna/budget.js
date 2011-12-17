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
    _.bindAll(this, 'render', 'unrender', 'destroy', 'edit', 'update', 'stopEditing', 'cancel', 'checkForSubmit', 'error', 'parseAttributes')
    @model.bind('change', @render)
    @model.bind('remove', @unrender)
    @model.bind('error', @error)

  render: ->
    $(@el).html(@template(@model.toJSON()))
          .find('.currency').formatCurrency()
    return @

  template: (data) ->
    template = _.template($(@templateElement).text());
    template(data);
  
  unrender: ->
    $(@el).remove()
  
  destroy: ->
    @model.destroy()
  
  edit: ->
    $(@el).parents("table")
          .removeClass("adding")
          .find('tbody tr')
          .removeClass("editing")

    $(@el).addClass("editing")        
          .find('input:first')
          .focus()
  
  checkForSubmit: (e) ->
    if e.keyCode == 13
      @update()
    else if e.keyCode == 27
      @stopEditing()

  stopEditing: ->
    $(@el).removeClass("editing").find(".error").removeClass(".error")
  
  parseAttributes: ->
    e = $(@el)
    amount: e.find(".amount").val()
    description: e.find(".description").val()
    payee: e.find(".payee").val()
    timing: e.find(".timing").val()

  update: ->
    if @model.set(@parseAttributes())
      @model.save()
      @stopEditing()

  cancel: -> 
    @stopEditing()
  
  error: (model, errors) ->
    $(@el).find(".error").removeClass("error")
    for error in errors
      $(@el).find(".#{error.field}").addClass("error")