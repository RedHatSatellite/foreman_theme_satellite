# This calls the main test_helper in Foreman-core
require 'test_helper'

# Add plugin to FactoryGirl's paths
FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryBot.reload

class ActionDispatch::IntegrationTest
  setup :disable_webpack

  # functional tests will fail if assets are not compiled because page
  # rendering will try to include the webpack assets path which will throw an
  # exception.
  def disable_webpack
    Webpack::Rails::Manifest.stubs(:asset_paths).returns([])
  end
end
