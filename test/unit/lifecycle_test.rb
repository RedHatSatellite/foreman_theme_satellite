require 'test_plugin_helper'

class LifecycleTest < ActiveSupport::TestCase
  test "gracefully accepts non-existing metadata" do
    ForemanThemeSatellite.send(:const_set, 'LIFECYCLE_METADATA_PATH', theme_fixture_file('lifecycle-metadata-nope.yml'))

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('something')
    expected = { current_version: 'something' }

    assert_equal expected, lifecycle_data
  end

  test "loads file correctly" do
    ForemanThemeSatellite.send(:const_set, 'LIFECYCLE_METADATA_PATH', theme_fixture_file('lifecycle-metadata.yml'))

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('25.25')

    assert lifecycle_data[:end_of_life]
    assert_nil lifecycle_data[:status]
  end

  test "sets status to danger after EOL date" do
    ForemanThemeSatellite.send(:const_set, 'LIFECYCLE_METADATA_PATH', theme_fixture_file('lifecycle-metadata.yml'))
    fake_now = Time.find_zone('UTC').parse('2525-12-31')
    Time.zone.stubs(:now).returns(fake_now)

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('25.25')

    assert 'danger', lifecycle_data[:status]
  end
end
