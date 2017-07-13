require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Your Title Goes Here"
  @contents = File.readlines('data/toc.txt')
  erb :home
end

get "/chapters/1" do
  @title = "Chapter 1"
  @contents = File.readlines('data/toc.txt')
  @chapter = File.readlines('data/chp1.txt')

  erb :chapter
end
