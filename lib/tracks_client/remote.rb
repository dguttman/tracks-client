module Tracks
  
  # TODO: Put these into the context, project, todo model files
  class RemoteBase < ActiveResource::Base
    
    def ar_attributes
      ar_attributes = attributes.merge({"remote_id" => self.id})
      
      ar_attributes.delete("id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes
    end
    
    def destroy
      self.class.delete(self.id)
    end
    
  end

  class RemoteTodo < RemoteBase
    self.element_name = "todo"
    
    def ar_attributes
      ar_attributes = super
      # ar_attributes["remote_project_id"] = attributes["project_id"]
      ar_attributes.delete("project_id")
      # ar_attributes["remote_context_id"] = attributes["context_id"]
      ar_attributes.delete("context_id")
      ar_attributes
    end
  end

  class RemoteContext < RemoteBase
    self.element_name = "context"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:context_id => id})
    end
  end
  
  class RemoteProject < RemoteBase
    self.element_name = "project"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:project_id => id})
    end
  end

end


# >> my_pc = Tracks::Context.find(:first)
# => #<Tracks::Context:0x139c3c0 @prefix_options={}, @attributes={"name"=>"my pc", "updated_at"=>Mon Aug 13 02:56:18 UTC 2007, "hide"=>0, "id"=>8, "position"=>1, "created_at"=>Wed Feb 28 07:07:28 UTC 2007}
# >> my_pc.name
# => "my pc"
# >> my_pc.todos
# => [#<Tracks::Todo:0x1e16b84 @prefix_options={}, @attributes={"context_id"=>8, "completed_at"=>Tue Apr 10 12:57:24 UTC 2007, "project_id"=>nil, "show_from"=>nil, "id"=>1432, "notes"=>nil, "description"=>"check rhino mocks bug", "due"=>Mon, 09 Apr 2007, "created_at"=>Sun Apr 08 04:56:35 UTC 2007, "state"=>"completed"}, #<Tracks::Todo:0x1e16b70 @prefix_options={}, @attributes={"context_id"=>8, "completed_at"=>Mon Oct 10 13:10:21 UTC 2005, "project_id"=>10, "show_from"=>nil, "id"=>17, "notes"=>"fusion problem", "description"=>"Fix Client Installer", "due"=>nil, "created_at"=>Sat Oct 08 00:19:33 UTC 2005, "state"=>"completed"}]
#
# >> t = Tracks::Todo.new
# => #<Tracks::Todo:0x1ee9fc0 @prefix_options={}, @attributes={}>

# >> t.description = "do it now"
# => "do it now"

# >> t.context_id = 8
# => 8

# >> t.save
# => true

# >> t.reload
# => #<Tracks::Todo:0x1ee9fc0 @prefix_options={}, @attributes={"completed_at"=>nil, "context_id"=>8, "project_id"=>nil, "show_from"=>nil, "notes"=>nil, "id"=>1791, "description"=>"do it now", "due"=>nil, "created_at"=>Mon Dec 03 19:15:46 UTC 2007, "state"=>"active"}

# >> t.put(:toggle_check)
# => #<Net::HTTPOK 200 OK readbody=true>

# >> t.reload
# => #<Tracks::Todo:0x1ee9fc0 @prefix_options={}, @attributes={"completed_at"=>Mon Dec 03 19:17:46 UTC 2007, "context_id"=>8, "project_id"=>nil, "show_from"=>nil, "notes"=>nil, "id"=>1791, "description"=>"do it now", "due"=>nil, "created_at"=>Mon Dec 03 19:15:46 UTC 2007, "state"=>"completed"}