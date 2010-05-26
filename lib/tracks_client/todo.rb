module Tracks
  class Todo < ActiveRecord::Base

    validates_uniqueness_of :remote_todo_id
  
    belongs_to :project
    belongs_to :context
  
    def remote_todo
      RemoteTodo.find(:first, :params => {:id => self.remote_todo_id})
    end

  end
end