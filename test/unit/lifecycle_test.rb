require 'test_plugin_helper'

class LifecycleTest < ActiveSupport::TestCase
  setup do
    @lifecycle_metadata_path = ForemanThemeSatellite::LIFECYCLE_METADATA_PATH
    @metadata_yaml = ForemanThemeSatellite.instance_variable_get(:@metadata_yaml)
  end

  teardown do
    ForemanThemeSatellite.send(:remove_const, 'LIFECYCLE_METADATA_PATH')
    ForemanThemeSatellite.const_set('LIFECYCLE_METADATA_PATH', @lifecycle_metadata_path)
    ForemanThemeSatellite.instance_variable_set(:@metadata_yaml, @metadata_yaml)
  end

  def use_lifecycle_metadata(filename)
    ForemanThemeSatellite.send(:remove_const, 'LIFECYCLE_METADATA_PATH')
    ForemanThemeSatellite.const_set('LIFECYCLE_METADATA_PATH', theme_fixture_file(filename))
  end

  test "gracefully accepts non-existing metadata" do
    use_lifecycle_metadata('lifecycle-metadata-nope.yml')

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('25.17.1234-alpha')
    expected = { current_version: '25.17.1234-alpha', short_version: '25.17' }

    assert_equal expected, lifecycle_data
  end

  test "uses the Satellite version from lifecycle metadata" do
    use_lifecycle_metadata('lifecycle-metadata-version.yml')
    ForemanThemeSatellite.instance_variable_set(:@metadata_yaml, {})

    assert_equal '99.99.0-test', ForemanThemeSatellite.get_satellite_version
  end

  test "prefers explicit version metadata" do
    use_lifecycle_metadata('lifecycle-metadata-version.yml')
    ForemanThemeSatellite.instance_variable_set(:@metadata_yaml, { 'version' => '6.18.0-test' })

    assert_equal '6.18.0-test', ForemanThemeSatellite.get_satellite_version
  end

  test "loads file correctly" do
    use_lifecycle_metadata('lifecycle-metadata.yml')

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('25.25')

    assert lifecycle_data[:end_of_life]
    assert_nil lifecycle_data[:status]
  end

  test "sets status to danger after EOL date" do
    use_lifecycle_metadata('lifecycle-metadata.yml')
    fake_now = Time.find_zone('UTC').parse('2525-12-31')
    Time.zone.stubs(:now).returns(fake_now)

    lifecycle_data = ForemanThemeSatellite::Lifecycle.lifecycle_data('25.25')

    assert 'danger', lifecycle_data[:status]
  end
end
