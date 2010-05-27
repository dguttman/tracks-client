module Tracks
  class Project < ActiveRecord::Base
  
    validates_uniqueness_of :remote_id
  
    has_many :todos
  
    def self.new_from_remote(remote_project)
      existing_project = self.find_by_remote_id(remote_project.id)
      if existing_project
        existing_time = existing_project.updated_at
        remote_time = remote_project.updated_at
        if existing_time < remote_time
          existing_project.update_attributes(remote_project.ar_attributes)
          return existing_project
        end
      else
        project = self.new(remote_project.ar_attributes)
        return project.save
      end
    end
  
    def remote_project
      RemoteProject.find(:first, :params => {:id => self.remote_id})
    end
  
  end
  
end