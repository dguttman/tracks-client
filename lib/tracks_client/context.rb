module Tracks
  class Context < ActiveRecord::Base

    validates_uniqueness_of :remote_id
    validates_uniqueness_of :position
    validates_uniqueness_of :name

    has_many :todos

    def self.new_from_remote(remote_context)
      existing_context = self.find_by_remote_id(remote_context.id)
      if existing_context
        synced_time = existing_context.synced_at
        modified_time = existing_context.updated_at
        remote_time = remote_context.updated_at
        if synced_time < remote_time && modified_time < remote_time
          existing_context.update_attributes(remote_context.ar_attributes)
          existing_context.synced_at = Time.now
          return existing_context
        end
      else
        context = self.new(remote_context.ar_attributes)
        context.synced_at = Time.now
        return context.save
      end
    end
  
    def sync_to_remote
      existing_context = remote_context
      if existing_context
        existing_time = existing_context.updated_at
        if existing_time < self.updated_at && self.updated_at != self.created_at
          remote_context.attributes = self.ar_attributes
          remote_context.save
        end
      else
        remote_context = RemoteContext.new(self.ar_attributes)
        if remote_context.save
          remote_context.reload
          self.remote_id = remote_context.id
          return remote_context
        end
      end
    end
  
    def remote_context
      if self.remote_id
        RemoteContext.find(self.remote_id)
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