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

	#возвращаем представление в details.erb
#	erb :details
end

post '/details/:id' do

	@c = Comment.new params[:comment]
	@c.save
#	post_id = params[:post_id]
#	content = params[:content]

#	if content.length <= 0
#  		@error = 'Введите текст комментария'
#  		return erb ('/details/' + post_id)
#  	end

	#сохранение данных в БД
#  	@db.execute 'insert into Comments 
#  		(
#  			content, 
#  			ceated_date, 
# 			post_id
#  		) 
# 		values 
#  		(
#  			?,
#  			datetime(),
#  			?
#  		)', [content, post_id] # сколько занков ? столько и элементов в масиве
			 
#	erb "You typed comment #{content} for post #{post_id}"

	#перенаправляем на страницу поста
#	 redirect to('/details/' + post_id)
end