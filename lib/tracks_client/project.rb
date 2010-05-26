module Tracks
  class Project < ActiveRecord::Base
  
    validates_uniqueness_of :remote_project_id
  
    has_many :todos
  
    def remote_project
      RemoteProject.find(:first, :params => {:id => self.remote_project_id})
    end
  
  end
end