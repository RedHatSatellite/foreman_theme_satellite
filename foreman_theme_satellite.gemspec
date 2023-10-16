require File.expand_path('lib/foreman_theme_satellite/version', __dir__)
require 'date'

Gem::Specification.new do |s|
  s.name        = "foreman_theme_satellite"
  s.version     = ForemanThemeSatellite::VERSION
  s.date        = Date.today.to_s
  s.authors     = ["Alon Goldboim, Shimon Stein"]
  s.email       = ["agoldboi@redhat.com"]
  s.homepage    = 'https://github.com/RedHatSatellite/foreman_theme_satellite'
  # also update locale/gemspec.rb
  s.description = "Theme changes for Satellite 6."
  s.files = Dir['{app,config,db,lib,locale,webpack}/**/*'] +
            ['LICENSE', 'Rakefile', 'README.md'] +
            ['package.json']
  s.files -= Dir['**/*.orig']
  s.test_files = Dir['test/**/*']
  s.test_files -= Dir['test/**/*.orig']
  s.add_dependency "deface"
  s.add_dependency "activesupport"
end
