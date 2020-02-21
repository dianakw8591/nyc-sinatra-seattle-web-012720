class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :"application/index"
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end


end
