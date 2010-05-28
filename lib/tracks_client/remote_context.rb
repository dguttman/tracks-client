require File.join(File.dirname(__FILE__), 'remote_base')

module Tracks

  class RemoteContext < RemoteBase
    self.element_name = "context"
  
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:context_id => id})
    end
  end

end