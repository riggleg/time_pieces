# -*- encoding: utf-8 -*-
#$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "time_pieces"
  # s.version     = "0.1.0"
  # s.platform    = "2.2"
  # s.license     = "MIT"
  # s.authors     = ["Grant R."]
  # s.email       = "grant@arsemporium.com"
  # s.homepage    = "http://github.com/riggleg/time_pieces"
  # s.summary     = "Time based operations."
  # s.description = "time_pieces is a library to make it easy to add/subtract time from a schedule"

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

  s.add_runtime_dependency %q<activesupport>, '~> 4.2'

  s.add_development_dependency 'rake',     '~> 10.5'
  s.add_development_dependency 'cucumber', '~> 2.3.2'
end
