require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir["public/*.*"]
  @files = @files.reverse if params[:sort] == "descending"
  erb :home
end
