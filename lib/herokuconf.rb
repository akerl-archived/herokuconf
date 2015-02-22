##
# Base module for HerokuConf
module HerokuConf
  class << self
    ##
    # Insert a helper .new() method for creating a new App object
    def new(*args)
      self::App.new(*args)
    end
  end
end

require 'herokuconf/app'
