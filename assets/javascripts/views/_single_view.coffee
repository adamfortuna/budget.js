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
    @model.bind('change', this.render)
    @model.bind('remove', this.unrender)
    @model.bind('error', this.error)

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
    $(this.el).parents("table").find('tbody tr').removeClass("editing")
    $(this.el).addClass("editing")
  
  checkForSubmit: (e) ->
    if e.keyCode == 13
      @update()
    else if e.keyCode == 27
      @stopEditing()

  stopEditing: ->
    $(this.el).removeClass("editing")
  
  update: ->
    if @model.set(
      amount: $(this.el).find(".amount").val()
      description: $(this.el).find(".description").val()
      payee: $(this.el).find(".payee").val()
      timing: $(this.el).find(".timing").val()
    )
      @stopEditing()

  cancel: -> 
    @stopEditing()
  
  error: (model, errors) ->
    for error in errors
      console.log("#{error.field} #{error.message}")