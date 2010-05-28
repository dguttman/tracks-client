require File.join(File.dirname(__FILE__), '..', 'lib', 'tracks_client')
require 'sinatra'
require 'haml'
require 'sass'

include Tracks
$client = Client.new

UPDATE_FREQ_MINS = 1

Thread.new do
  while true
    sleep 60 * UPDATE_FREQ_MINS
    p "Syncing !! "
    $client.sync_to_local
    $client.sync_to_remote
    p "Sync Complete"
  end
end

get '/' do
  @first_context = Context.find_by_position(1)
  haml :index
end

post '/todos' do
  @context = Context.find_by_name(params[:context][:name])
  @todo = @context.todos.create(params[:todo])
  @todo.description
end

get '/sync' do
  $client.sync_to_local
  $client.sync_to_remote
end

get '/contexts' do
  @contexts = $client.contexts
end

# SASS stylesheet
get '/stylesheets/style.css' do
  content_type  'text/css', :charset => 'utf-8'
  sass :style
end