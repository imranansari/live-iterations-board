class window.EpicView extends Backbone.View
  events:
    "click .editEpicNote": "edit"

  initialize: ->
    _.bindAll this, "render"

  edit: ->
    window.epicController.editEpic @model

  render: ->
    source = $("#epicItemView").html()
    template = Handlebars.compile(source)
    console.log @model.toJSON()
    console.log template(@model.toJSON())
    $(@el).html template(@model.toJSON())
    @


class window.UpdatingEpicView extends window.EpicView
 initialize: (options) ->
  @render = _.bind(@render, this)
  @model.bind "change:storyName", @render
  @model.bind "change:storyDesc", @render
  console.log @model
  @

class window.EpicEditView extends window.UpdatingEpicView
  events: 
    "click #deleteEpicStory": "destroy"
    "click #saveEpicStory": "update"
    "click .closeNote": "closeDialog"

  ###
  initialize: ->
    _.bindAll this, "contentChanged"
    @inputContent = @$("input.content")
    console.log @inputContent.valueOf()
    @
  ###

  render: ->
    source = $("#editableEpicStoryDlg").html()
    template = Handlebars.compile(source)
    $(@el).html template(@model.toJSON())
    @
  
  destroy: ->
    console.log @model.toJSON().storyName
    console.log @model.toJSON()._id
    @model.destroy()
    @
  
  update: ->
    console.log "changed form"
    form = "#editableEpicStoryForm_" + @model.toJSON()._id
    formData = $(form).serializeObject()
    console.log formData
    console.log @model.toJSON()
    console.log @model.id
    window.epicController.updateEpic(@model.id, formData)
    false

  closeDialog: ->
    $("#lightBoxContent").trigger('close');


class window.NewEpicView extends Backbone.View
  events: "submit form": "onSubmit"
  initialize: ->
    _.bindAll this, "contentChanged"
    @inputContent = @$("input.content")
    console.log @inputContent.valueOf()
  
  render: ->
    source = $("#newEpicDlg").html()
    template = Handlebars.compile(source)
    $(@el).html template(id: "1")
    @
  
  onSubmit: (e) ->
    console.log "changed form"
    form = "#newEpicStoryForm_1"
    formData = $(form).serializeObject()
    console.log formData
    new EpicController().saveEpic formData
    false