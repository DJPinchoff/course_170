require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

get "/" do
  redirect "/users"
end

get "/users" do
  @database = Psych.load_file("users.yml")
  
  erb :users
end
