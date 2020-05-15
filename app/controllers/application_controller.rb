
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect('/articles')
  end

  #create
  get ('/articles/new') {erb :new}

  post ('/articles') {
    
    @article = Article.create(title: params[:title], content: params[:content])
    redirect ("/articles/#{@article.id}")
  }

  get ('/articles') {
    @articles = Article.all
    erb :index
  }

  get('/articles/:id') {
    @article = Article.find_by(id: params[:id])
    
    erb :show
  }

  #edit
  get ('/articles/:id/edit') {
    @article = Article.find_by(id: params[:id])
    erb :edit
  }
  
  patch('/articles/:id') {
    @article = Article.find_by(id: params[:id])
    @article.update(params[:article])
    redirect ("/articles/#{@article.id}")
  }

  #delete
  delete('/articles/:id') {
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect ('/articles')
  }
end
