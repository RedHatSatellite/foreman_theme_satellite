require File.expand_path('lib/foreman_theme_satellite/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_theme_satellite'
  s.version     = ForemanThemeSatellite::VERSION
  s.metadata    = { 'is_foreman_plugin' => 'true' }
  s.license     = 'GPL-3.0'
  s.authors     = ['Shimon Stein', 'Eric Helms']
  s.email       = ['sshtein@redhat.com', 'ehelms@redhat.com']
  s.homepage    = 'https://github.com/RedHatSatellite/foreman_theme_satellite'
  s.summary     = 'This is a plugin that enables building a theme for Foreman.'
  # also update locale/gemspec.rb
  s.description = 'Theme changes for Satellite 6.'
  s.files = Dir['{app,config,db,lib,locale,webpack}/**/*'] +
            ['LICENSE', 'Rakefile', 'README.md'] +
            ['package.json']

  s.required_ruby_version = '>= 2.7'

  s.add_dependency "activesupport"
  s.add_dependency "deface"
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'theforeman-rubocop', '~> 0.1.0'
end
