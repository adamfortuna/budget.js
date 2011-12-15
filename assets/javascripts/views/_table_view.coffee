window.App.TableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'click .create': 'create'
    'click .add_new': 'showForm'
    'click .new_row_template .hide': 'hideForm'
    'keyup .new_row_template input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'create', 'appendItem', 'appendItemAndResort', 'checkForSubmit', 'template', 'clearForm', 'showForm', 'hideForm', 'resort', 'error')
    @collection = @collectionClass
    @collection.fetch()
    @collection.bind('add', @appendItemAndResort)
    @collection.bind('remove', @resort)

  render: ->
    $(@el).append(@template())
    _(@collection.models).each ((item) ->
      @appendItem item
    ), @
    @resort()
    @el

  template: ->
    template = _.template($(@templateElement).text());
    template.apply(@, arguments);

  checkForSubmit: (e) ->
    if e.keyCode == 13
      @create()
    else if e.keyCode == 27
      @hideForm()

  appendItemAndResort: (item) ->
    @appendItem item
    @resort()

  appendItem: (item) ->
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
    item = new @modelClass(
      description: form.find(".description").val()
      payee: form.find(".payee").val()
      amount: form.find(".amount").val()
      timing: form.find(".timing").val()
    )
    item.bind('error', @error)
    
    if @collection.create(item)
      console.log('created')
      @clearForm()
      form.find(".description").focus()
  
  resort: ->
    $(@el).find('.datatable').dataTable(
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "sDom": '<""f>t<"F"lp>'
    )

  error: (model, errors) ->
    console.log('error occured')
    for error in errors
      console.log("#{error.field} #{error.message}")