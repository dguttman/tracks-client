require 'ostruct'

module Tracks
  
  class Project < OpenStruct
    
    def initialize(parent, hash)
      @parent = parent
      super(hash)
    end
    
    def todos
      @parent.project_todos(self.id)
    end
    
  end
  
end