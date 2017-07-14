require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @database = Psych.load_file("users.yml")
  @number_of_users = @database.keys.size
end

get "/" do
  redirect "/users"
end

get "/users" do
  @title = "User Directory"
  erb :users
end

get "/users/:name" do
  @name = params[:name]
  @title = "#{@name.capitalize}'s Page"
  erb :user
end

helpers do
  def other_users(name)
    result = []
    @database.each_key do |key|
      result << key unless key == name
    end
    result
  end

  def count_interests
    count = 0
    @database.each do |key, value|
      value[:interests].each do |_|
        count += 1
      end
    end

    count
  end
end
