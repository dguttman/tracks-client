module Tracks
  class Context < ActiveRecord::Base

    validates_uniqueness_of :remote_context_id

    has_many :todos
  
    def remote_context
      RemoteContext.find(:first, :params => {:id => self.remote_context_id})
    end
  
  end
end