require 'ostruct'

module Tracks
  class Todo < OpenStruct
    def initialize(parent, hash)
      @parent = parent
      super(hash)
    end
  end
end