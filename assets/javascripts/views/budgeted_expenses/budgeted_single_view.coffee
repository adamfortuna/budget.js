window.BudgetedSingleView = Backbone.View.extend
  tagName: 'tr'
  events: 
    'click .delete': 'remove'

  initialize: ->
    _.bindAll(this, 'render', 'unrender', 'remove')
    @model.bind('change', this.render)
    @model.bind('remove', this.unrender)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return @

  template: (data) ->
    compiled = _.template("<td><%= description %></td><td><%= payee %></td><td><%= amount %></td><td><%= timing %></td><td><a href='#budeted' class='delete'>remove</a></td>")
    compiled(data)
  
  unrender: ->
    $(@el).remove()
  
  remove: ->
    @model.destroy()