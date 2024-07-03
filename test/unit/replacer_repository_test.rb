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
    actual = _('http proxy for smart proxy')

    assert_equal 'HTTP proxy for Capsule', actual
  end

  test 'random branding test' do
    # Tests branding based on strings randomly picked from Foreman- and Satellite-documentation
    test_strings = [
      'An operating system is a collection of resources that define how Foreman server installs a base operating system on a host.',
      'Installing the Infoblox CA certificate on Smart Proxy server',
      'In the Foreman web UI, navigate to Infrastructure > Smart Proxies, select the Smart Proxy with the DHCP Infoblox module, and ensure that the dhcp feature is listed.',
      'Foreman Server automatically manages the PXE configuration, organizes networking services, and provides the operating system and configuration for the host.',
      'In Foreman, you can create an HTTP proxy and then assign the HTTP proxy to your EC2 compute resource.',
    ]
    translated_strings = [
      'An operating system is a collection of resources that define how Satellite server installs a base operating system on a host.', # Pr. Hosts: 2.3
      'Installing the Infoblox CA certificate on Capsule server', # Pr. Hosts: 4.3
      'In the Satellite web UI, navigate to Infrastructure > Capsules, select the Capsule with the DHCP Infoblox module, and ensure that the dhcp feature is listed.', # Pr. Hosts: 4.4
      'Satellite Server automatically manages the PXE configuration, organizes networking services, and provides the operating system and configuration for the host.', # Pr. Hosts: 5.3
      'In Satellite, you can create an HTTP proxy and then assign the HTTP proxy to your EC2 compute resource.', # Pr. Hosts: 14.4
    ]

    test_strings.zip(translated_strings).each do |original, target|
      assert_equal target, _(original)
    end
  end
end
