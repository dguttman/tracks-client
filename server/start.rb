require File.join(File.dirname(__FILE__), '..', 'lib', 'tracks_client')
require 'sinatra'

p "attempting sinatra start"
get '/' do
  @client = Tracks::Client.new
  output = ""
  @client.todos.each do |todo|
    output << todo.description
    output << "<br />"
  end
  output
end
