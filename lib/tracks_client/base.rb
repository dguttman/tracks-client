module Tracks
  
  class Base < ActiveRecord::Base

    self.abstract_class = true

    validates_uniqueness_of :remote_id

    def self.new_from_remote(remote)
      existing = self.find_by_remote_id(remote.id)
      if existing
        update_existing_with_remote(existing, remote)
      else
        create_new_with_remote(remote)
      end
    end
    
    def self.create_new_with_remote(remote)
      local = self.new(remote.ar_attributes)
      local.synced_at = Time.now
      return local.save
    end
    
    def self.update_existing_with_remote(existing, remote)
      synced_time = existing.synced_at
      modified_time = existing.updated_at
      remote_time = remote.updated_at
      if synced_time < remote_time && modified_time < remote_time
        existing.update_attributes(remote.ar_attributes)
        existing.synced_at = Time.now
        return existing
      end
    end
  
    def sync_to_remote
      if remote
        update_remote
      else
        create_remote
      end
    end
  
    def create_remote
      remote = remote_class.new(self.ar_attributes)
      if remote.save
        remote.reload
        self.remote_id = remote.id
        return remote
      end
    end
  
    def update_remote
      remote_time = remote.updated_at
      if remote_time < self.updated_at && self.updated_at > self.created_at
        remote.attributes = self.ar_attributes
        remote.save
      end
    end
  
    def remote
      if self.remote_id
        remote_class.find(self.remote_id)
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