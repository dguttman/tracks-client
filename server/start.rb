require File.join(File.dirname(__FILE__), '..', 'lib', 'tracks_client')
require 'sinatra'
require 'haml'
require 'sass'

Client = Tracks::Client.new

get '/' do
  
  @todos = Client.todos
  haml :index
end

get '/contexts' do
  @contexts = Client.contexts
end

# SASS stylesheet
get '/stylesheets/style.css' do
  content_type  'text/css', :charset => 'utf-8'
  sass :style
end