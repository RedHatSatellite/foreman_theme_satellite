# This calls the main test_helper in Foreman-core
require 'test_helper'

# Add plugin to FactoryBot's paths
FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryBot.reload

def theme_fixture_file(filename)
  ForemanThemeSatellite::Engine.root.join('test', 'fixtures', filename)
end
