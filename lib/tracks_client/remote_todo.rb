require File.join(File.dirname(__FILE__), 'remote_base')

module Tracks

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

end