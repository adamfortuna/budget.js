window.App.IncomeSingleView = Backbone.View.extend
  tagName: 'tr'
  events: 
    'click span': 'activateForm'
    'click .delete': 'remove'
    'click .edit': 'edit'
    'click .update': 'update'
    'click .cancel': 'cancel'
    'keyup input': 'checkForSubmit'

  initialize: ->
    _.bindAll(this, 'render', 'unrender', 'remove')
    @model.bind('change', this.render)
    @model.bind('remove', this.unrender)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return @

  template: (data) ->
    template = _.template($("#single_row_template").text());
    template(data)
  
  unrender: ->
    $(@el).remove()
  
  remove: ->
    console.log("incomesingle view delete")
    @model.destroy()
  
  edit: ->
    $(this.el).addClass("editing")
  
  checkForSubmit: (e) ->
    @update() if e.keyCode == 13
    
  stopEditing: ->
    $(this.el).removeClass("editing")
  
  update: ->
    @model.set(
      amount: $(this.el).find(".amount").val()
      description: $(this.el).find(".description").val()
      payee: $(this.el).find(".payee").val()
      timing: $(this.el).find(".timing").val()
    )
    @stopEditing()

  cancel: -> 
    @stopEditing()
    
  activateForm: ->
    console.log("testing")
    $(this.el).addClass("editing")