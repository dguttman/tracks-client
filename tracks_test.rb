Dir["lib/*.rb"].each {|file| require file }

auth = YAML.load_file(File.join(ENV["HOME"], ".tracks_client"))

client = Tracks::Client.new(auth["username"], auth["password"])

interface = Tracks::Interface.new(client)

interface.list_todos_by_context(6)