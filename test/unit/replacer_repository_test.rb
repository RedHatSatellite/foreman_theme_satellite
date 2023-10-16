require 'test_plugin_helper'

class TranslationsTest < ActiveSupport::TestCase
  test 'Brands a single instance of branded word' do
    actual = _('Welcome to Foreman')

    assert_equal 'Welcome to Satellite', actual
  end

  test 'Brands multiple instances of branded word' do
    actual = _('Welcome to Foreman. Foreman is awesome')

    assert_equal 'Welcome to Satellite. Satellite is awesome', actual
  end

  test 'Can work with whitelist branding' do
    actual = _('HTTP proxy for proxy')

    assert_equal 'HTTP Proxy for Capsule', actual
  end
end
