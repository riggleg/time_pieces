require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '../../lib'))
require 'time_pieces.rb'
require 'minitest/autorun'

After do |scenario|
  Cucumber.wants_to_quit = true if scenario.failed?
end
