EpicModel = Backbone.Model.extend({
    idAttribute: "_id",
    defaults : {
        storyName : "This is the story hi hi",
        phase : "Definition",
        storyCount : "0"
    }
});

EpicModels = Backbone.Collection.extend({url:'/epic_board/epic',
    model:EpicModel});


StoryModel = Backbone.Model.extend({
    idAttribute: "_id",
    defaults : {
        storyName : "This is the story dumass",
        phase : "Definition",
        storyDesc : "Story Description..",
        assigned : "Homer"
    }
});

StoryModels = Backbone.Collection.extend({url:'/epic_board/epic',
    model:EpicModel});
