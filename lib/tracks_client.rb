require 'rubygems'
require 'active_record'
require 'active_resource'
require 'attr_remote'
require 'ap'

module Tracks

  class Client
    attr_reader :cache_time
    
    def initialize(u, p)
      @auth = {:username => u, :password => p}
      @cache_time = {}
    end

  end
  
end