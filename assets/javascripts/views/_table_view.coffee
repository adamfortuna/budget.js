window.App.TableView = Backbone.View.extend
  tagName: 'section'
  events: 
    'click .create': 'create'
    'click .add_new': 'showForm'
    'click .new_row_template .hide': 'hideForm'
    'keyup .new_row_template input': 'checkForSubmit'

  initialize: ->
    _.bindAll(@, 'render', 'create', 'appendItem', 'appendItemAndResort', 'checkForSubmit', 'template', 'clearForm', 'showForm', 'hideForm', 'resort', 'error', 'parseAttributes')
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
    $(@el).find(".new_row_template").find(".error").removeClass("error")
    $(@el).find("thead input[type='text']").val("")

  showForm: ->
    $(@el).find("table tr").removeClass("editing")
    $(@el).find("table").addClass("adding").find("input:first").focus()

  hideForm: ->
    @clearForm()
    $(@el).find("table").removeClass("adding")
  
  parseAttributes: ->
    form = $(@el).find(".new_row_template")
      
    description: form.find(".description").val()
    payee: form.find(".payee").val()
    amount: form.find(".amount").val()
    timing: form.find(".timing").val()

  create: ->
    form = $(@el).find(".new_row_template")
    item = new @modelClass()
    attributes = @parseAttributes()
    errors = item.validate(attributes)
    
    if errors && errors.length > 0
      console.log("errors")
      @error(errors)
    else
      @collection.create(attributes)
      console.log('collection created')
      @clearForm()
      form.find("input:first").focus()
  
  resort: ->
    # $(@el).find('.datatable').dataTable(
    #   "bJQueryUI": true,
    #   "sPaginationType": "full_numbers",
    #   "sDom": '<""f>t<"F"lp>'
    # )
    

  error: (errors) ->
    $(@el).find(".new_row_template .error").removeClass("error")
    for error in errors
      $(@el).find(".new_row_template .#{error.field}").addClass("error")