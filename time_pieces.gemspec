# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_pieces/version'

Gem::Specification.new do |spec|

  spec.name          = "time_pieces"	
  spec.version       = TimePieces::VERSION
  spec.license       = "MIT"  
  spec.authors     = ["Grant R."]
  spec.email       = "grant@arsemporium.com"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_path = "lib"
  spec.homepage    = "http://github.com/riggleg/time_pieces"
  spec.summary     = "Time based operations."
  spec.description = "time_pieces is a library to make it easy to add/subtract time from a schedule"

  # s.files            = `git ls-files -- lib/*`.split("\n")
  #  s.files           += %w[README.md LICENSE.md Changelog.md Capybara.md .yardopts .document]
  # s.test_files       = []
  # s.require_path     = "lib"

#  private_key = File.expand_path('~/.gem/rspec-gem-private_key.pem')
#  if File.exist?(private_key)
#    s.signing_key = private_key
#    s.cert_chain = [File.expand_path('~/.gem/rspec-gem-public_cert.pem')]
#  end


#  if RUBY_VERSION <= '1.8.7' && ENV['RAILS_VERSION'] != '3-2-stable'
#    version_string << '!= 3.2.22.1'
#  end
   spec.add_dependency 'bundler'
  spec.add_development_dependency %q<activesupport>, '~> 4.2'

  spec.add_development_dependency 'rake',     '~> 10.5'
  spec.add_development_dependency 'cucumber', '~> 2.3.2'
end
