require File.join(File.dirname(__FILE__), 'base')

module Tracks
  class Project < Base
  
    validates_uniqueness_of :name
  
    has_many :todos
    
    def remote_class
      RemoteProject
    end
  
  end
  
end