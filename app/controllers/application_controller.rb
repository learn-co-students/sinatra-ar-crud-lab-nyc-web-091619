
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all

    erb :index

  end

  post '/articles' do
    @article = Article.create(params)

    redirect "/articles/#{@article.id}"
  end

  get '/articles/new' do
    erb :new
  end
  
  get '/articles/:id' do
    @article = Article.find(params[:id].to_i)

    erb :show
  end

  get '/articles/:id/edit' do
    @id = params[:id]
    @article = Article.find(@id.to_i)
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    @article.title = params["title"]
    @article.content = params["content"]
    @article.save

    redirect "/articles/#{params[:id]}"

  end

  delete '/articles/:id' do #Delete
    Article.destroy(params[:id].to_i)
    redirect '/articles'

  end
 


end
