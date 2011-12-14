window.App.TableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'click .create': 'create'
    'click .add_new': 'showForm'
    'click .new_row_template .hide': 'hideForm'
    'keyup .new_row_template input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'create', 'addItem')
    @collection = @collectionClass
    @collection.fetch()
    @collection.bind('add', @addItem)

  render: ->
    $(@el).append(@template())
    _(@collection.models).each ((item) ->
      @addItem item
    ), @
    @el

  template: ->
    template = _.template($(@templateElement).text());
    template.apply(@, arguments);

  checkForSubmit: (e) ->
    if e.keyCode == 13
      @create()
    else if e.keyCode == 27
      @hideForm()

  addItem: (item) ->
    newItem = new @rowClass(model: item)
    $(@el).find("tbody").prepend(newItem.render().el)

  clearForm: ->
    $(@el).find("thead input[type='text']").val("")

  showForm: ->
    $(@el).find("table").addClass("adding")

  hideForm: ->
    @clearForm()
    $(@el).find("table").removeClass("adding")
    
  create: ->
    form = $(@el).find(".new_row_template")
    @collection.create(
      description: form.find(".description").val()
      payee: form.find(".payee").val()
      amount: form.find(".amount").val()
      timing: form.find(".timing").val()
    )
    @clearForm()
    form.find(".description").focus()