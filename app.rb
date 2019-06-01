#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
	validates :name, presence: true 
    validates :content, length: {minimum: 2}
end

class Comment < ActiveRecord::Base
end

before do
	@posts = Post.all
	@comments = Comment.all
end

get '/' do
	erb :index			
end

get '/new' do
	@p = Post.new
  	erb :new
end

post '/new' do
 	
 	@p = Post.new params[:post]
 	if @p.save
    erb "<h2> Спасибо! </h2>"
    else
      @error = @p.errors.full_messages.first
      erb :new
    end
end

#вывод информации о посте
get '/details/:id' do
	  
	  @post = Post.find(params[:id])
  	  erb :details

end

post '/details/:id' do

	@c = Comment.new params[:comment]
	@c.save

redirect to session.delete(:return_to)

end