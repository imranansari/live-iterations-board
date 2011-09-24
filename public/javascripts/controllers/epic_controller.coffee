class EpicController extends Backbone.Router

  epicModels: null

  routes:
    newstory: "newStory"
    display_epics: "displayEpics"

  newStory: ->
    alert "new story"

  saveEpic: (formData) ->
    newEpic = epicModels.create(formData)
    console.log newEpic
    updatedModel = epicModels.getByCid(newEpic.cid)
    console.log updatedModel

  updateEpic: (id, values) ->
    @epicModels.get(id).set(values).save()


  displayEpics: ->
    initData = @getEpicModelsFromService()
    @epicModels = new EpicModels(initData)
    #temp1 = new window.UpdatingEpicView()
    dashBoardCollectionView = new UpdatingDashboardCollectionView(
      collection: @epicModels
      childViewConstructor: window.UpdatingEpicView
      childViewTagName: "li"
    )
    dashBoardCollectionView.render()

  displayEpicBoard: ->
    data =
      phase1: "Definition"
      phase2: "Development"
      phase3: "QA"
      phase4: "Delivered"

    source = $("#epicBoardContainer").html()
    template = Handlebars.compile(source)
    html = template(data)
    $("#mainContainer").html html
    console.log('a');
    @setupDragDrop()

  updateEpicLocation: (epicsInPhase, updatedEpic) ->
    phaseId = $(updatedEpic).closest(".phasepanel").attr("id")
    phase = phaseId.substring(phaseId.indexOf("_") + 1)
    console.log phaseId
    modelId = $(updatedEpic).find(".editEpicNote").attr("refid")
    @epicModels.get(modelId).set(phase: phase).save()
    $(epicsInPhase).each ->
      console.log this

  setupDragDrop: =>
    $(".movable").sortable
      connectWith: ".movable"
      receive: (event, ui) ->
        #console.log "updated : " + ui.item[0].id
        #console.log $(this).sortable("serialize")
        window.epicController.updateEpicLocation($(this).sortable("toArray"), ui.item[0])
    $(".movable").disableSelection()

  getEpicModelsFromService: ->
    data =""
    $.ajax
      url: "/epic_board/epic"
      type: "GET"
      dataType: "json"
      async: false
      success: (dataFromService) ->
        data = dataFromService

    data

  editEpic: (editEpicModel) ->
    console.log editEpicModel.toJSON().phase
    epicEditView = new EpicEditView(model: editEpicModel)
    $("#lightBoxContent").html(epicEditView.render().el)
    $("#lightBoxContent").lightbox_me
      closeClick: false
      overlaySpeed: 50
      closeSelector: ".closeNote"
      appearEffect: "fadeIn"
      overlayDisappearSpeed: 0

  newEpic: ->
    newEpicView = new NewEpicView()
    $("#lightBoxContent").html newEpicView.render().el
    $("#lightBoxContent").lightbox_me
      closeClick: false
      overlaySpeed: 50
      closeSelector: ".closeNote"
      appearEffect: "fadeIn"
      overlayDisappearSpeed: 0


$ ->
  window.epicController = new EpicController()
  Backbone.history.start()
  window.epicController.displayEpicBoard();
  window.epicController.displayEpics();