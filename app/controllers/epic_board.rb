LiveIterationsBoard.controllers :epic_board do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index do
    render "epic_board/index"
  end

  get '/epic' do
    print 'list epics'
    content_type 'application/json'
    response['Expires'] = (Time.now).httpdate
    epics = Epic.all()

    epics.to_json
  end


put '/epic/:id' do
#message = JSON.parse(params[:model])
  print 'put'
  epic = JSON.parse(request.body.read)
  print epic.to_json
  print epic["_id"]
  updateEpic = Epic.where(:_id => epic["_id"]).first

  updateEpic.phase = epic["phase"]
  updateEpic.storyName = epic["storyName"]
  updateEpic.storyDesc = epic["storyDesc"]
  updateEpic.assigned = epic["assigned"]

  updateEpic.save
end

end
