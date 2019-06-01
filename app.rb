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
#get '/details/:post_id' do
	#получаем переменную из url'a
#	post_id = params[:post_id]

	#получаем список постов(у нас будет только один пост)
#	results = @db.execute 'select * from Posts where id = ?', [post_id]  #выбираются посты с id страницы
	#выбираем этот один пост в переменную row
#	@row = results[0]

	#выбираем комментарий для нашего поста
#	@comments = @db.execute 'select * from Comments where post_id = ? order by id', [post_id]

	#возвращаем представление в details.erb
#	erb :details
#end

#обработчик post-запроса /details/...  браузер отправляет данные на сервер, мы их принемае
#post '/details/:post_id' do
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
#end