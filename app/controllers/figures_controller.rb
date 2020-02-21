class FiguresController < ApplicationController
  # add controller methods

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    params.delete("_method")
    @figure.update(params)
    redirect "/figures/#{@figure.id}"
  end

  post '/figures' do
    # binding.pry
    @new_figure = Figure.create(name: params[:figure][:name])
    if !params[:title][:name] = ""
      @new_title = Title.create(params[:title])
      FigureTitle.create(figure_id: @new_figure.id, title_id: @new_title.id)
    end
    if !params[:landmark][:name] = ""
      @new_landmark = Landmark.create(params[:landmark])
      @new_landmark.figure_id = @new_figure.id
    end
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        FigureTitle.create(figure_id: @new_figure.id, title_id: id)
      end
    end
    redirect '/figures'
  end


end
