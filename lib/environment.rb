require 'httparty'
require 'json'
require 'pry'

require_relative "solar_system/version"
require_relative "solar_system/cli"
require_relative "solar_system/planet"

module Environment
  class Error < StandardError; end
  # Your code goes here...
end
