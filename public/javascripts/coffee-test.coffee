$(document).ready ->
    $('#displayEpics').click ->
        epicController = new EpicController()
        epicController.displayEpics()


window.MyController = class MyController
    constuctor: (myName) ->
        @someName = myName
    getName: ->
        @someName

myc = new MyController('imran')
console.log(myc.getName)