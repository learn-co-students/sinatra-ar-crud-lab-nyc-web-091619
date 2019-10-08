
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  get '/articles' do  # Index
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do # new
    erb :new
  end

  post '/articles' do # Create
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  get '/articles/:id' do # show
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  get '/articles/:id/edit' do #edit
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to "/articles"
  end
end
