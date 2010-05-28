module Tracks
  class Context < Base
    
    validates_uniqueness_of :position
    validates_uniqueness_of :name

    has_many :todos
  
    def remote_class
      RemoteContext
    end
  
  end
  
end