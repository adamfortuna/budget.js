window.App.BudgetedSingleView = Backbone.View.extend
  tagName: 'tr'
  events: 
    'click .delete': 'remove'
    'click .edit': 'edit'
    'submit .edit': 'stopEditing'

  initialize: ->
    _.bindAll(this, 'render', 'unrender', 'remove')
    @model.bind('change', this.render)
    @model.bind('remove', this.unrender)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return @

  template: (data) ->
    template = _.template($("#budgeted_single_template").text());
    template(data);
  
  unrender: ->
    $(@el).remove()
  
  remove: ->
    @model.destroy()
  
  edit: ->
    $(this.el).addClass("editing")
  
  stopEditing: ->
    $(this.el).removeClass("editing")