require 'active_support/all'
#lib = File.expand_path('../lib/', __FILE__)
lib = File.expand_path('.', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_pieces/version'
require 'time_pieces/time_duration.rb'
require 'time_pieces/time_set.rb'
