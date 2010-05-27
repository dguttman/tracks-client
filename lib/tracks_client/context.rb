module Tracks
  class Context < ActiveRecord::Base

    validates_uniqueness_of :remote_id

    has_many :todos

    def self.new_from_remote(remote_context)
      existing_context = self.find_by_remote_id(remote_context.id)
      if existing_context
        existing_time = existing_context.updated_at
        remote_time = remote_context.updated_at
        if existing_time < remote_time
          existing_context.update_attributes(remote_context.ar_attributes)
          return existing_context
        end
      else
        context = self.new(remote_context.ar_attributes)
        return context.save
      end
    end
  
    def remote_context
      RemoteContext.find(:first, :params => {:id => self.remote_id})
    end
  
  end
  
end