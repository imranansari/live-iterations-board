var UpdatingDashboardCollectionView = UpdatingCollectionView.extend({

    add : function(model) {
        var childView = new this._childViewConstructor({
            tagName : this._childViewTagName,
            model : model
        });

        this._childViews.push(childView);

        if (this._rendered) {
            //$(this.el).append(childView.render().el);
            console.log(childView.model.toJSON());
            var phase = childView.model.toJSON().phase;
            $('#story_' + phase + ' ul').append(childView.render().el);
        }
    },

    remove : function(model) {
        var viewToRemove,
                childView,
                leftSide,
                rightSide;

        for (var i = 0, length = this._childViews.length; i < length; i++) {
            childView = this._childViews[i];

            if (childView.model === model) {
                viewToRemove = childView;
                break;
            }
        }

        leftSide = this._childViews.slice(0, i);
        rightSide = this._childViews.slice(i + 1, length);

        this._childViews = leftSide.concat(rightSide);

        if (this._rendered) {
            $(childView.el).remove();
        }
    },

    render : function() {
        var that = this;
        this._rendered = true;

        this.$('*').remove();
        //$(this.el).html('');
         $('#story_QA ul').html('');
         $('#story_Definition ul').html('');
         $('#story_Development ul').html('');
         $('#story_Delivered ul').html('');

        _(this._childViews).each(function(childView) {
            //$(that.el).append(childView.render().el);
            var phase = childView.model.toJSON().phase;
            console.log(childView.render().el);
            $('#story_' + phase + ' ul').append(childView.render().el);
        });

        return this;
    }
});
