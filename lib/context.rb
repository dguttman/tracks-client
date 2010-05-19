require 'ostruct'

module Tracks
  
  class Context < OpenStruct
    def initialize(parent, hash)
      @parent = parent
      super(hash)
    end
    
    def todos
      @parent.context_todos(self.id)
    end
    
  end
  
end