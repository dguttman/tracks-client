module Tracks
  class Project < ActiveRecord::Base
  
    validates_uniqueness_of :remote_id
    validates_uniqueness_of :name
  
    has_many :todos
  
    def self.new_from_remote(remote_project)
      existing_project = self.find_by_remote_id(remote_project.id)
      if existing_project
        synced_time = existing_project.synced_at
        modified_time = existing_project.updated_at
        remote_time = remote_project.updated_at
        if synced_time < remote_time && modified_time < remote_time
          existing_project.update_attributes(remote_project.ar_attributes)
          existing_project.synced_at = Time.now
          return existing_project
        end
      else
        project = self.new(remote_project.ar_attributes)
        project.synced_at = Time.now
        return project.save
      end
    end

    def sync_to_remote
      existing_project = remote_project
      if existing_project
        existing_time = existing_project.updated_at
        if existing_time < self.updated_at && self.updated_at != self.created_at
          remote_project.attributes = self.ar_attributes
          remote_project.save
        end
      else
        remote_project = RemoteProject.new(self.ar_attributes)
        if remote_project.save
          remote_project.reload
          self.remote_id = remote_project.id
          return remote_project
        end
      end
    end
  
    def remote_project
      if self.remote_id
        RemoteProject.find(self.remote_id)
      end
    end
    
    def ar_attributes
      
      ar_attributes = attributes.dup
      
      ar_attributes.delete("id")
      ar_attributes.delete("remote_id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes.delete("synced_at")
      ar_attributes.delete_if { |k,v| v.nil? }
      ap ar_attributes
      
      ar_attributes
    end
  
  end
  
end