Dir["lib/*.rb"].each {|file| require file }


client = Tracks::Client.new("david", "tsljlj16")

ap client.todos
ap client.projects
ap client.contexts