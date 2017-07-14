require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir["public/*"].sort
  @files = @files.reverse if params[:sort] == "descending"
  erb :list
end
