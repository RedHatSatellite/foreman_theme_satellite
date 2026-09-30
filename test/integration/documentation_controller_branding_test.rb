require 'test_plugin_helper'

class DocumentationControllerBrandingTest < ActionDispatch::IntegrationTest
  test 'documentation routes land at the versioned root' do
    %w[
      /links/manual/4.1.5Searching
      /links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts
      /links/docs/Unknown_Guide?chapter=unknown
      /links/plugin_manual?name=foreman_ansible
      /links/wiki/Mail_Notifications
      /links/upgrade/documentation
    ].each do |path|
      get path
      assert_redirected_to "https://docs.redhat.com/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}"
    end
  end

  test 'landing root uses the configured documentation server' do
    original_url = Setting[:satellite_documentation_url]
    Setting[:satellite_documentation_url] = 'https://offline.example/docs'
    get '/links/docs/Managing_Hosts?chapter=example'
    assert_redirected_to "https://offline.example/docs/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}"
  ensure
    Setting[:satellite_documentation_url] = original_url
  end

  test 'support and upgrade helper keep their destinations' do
    get '/links/support'
    assert_redirected_to 'https://access.redhat.com/products/red-hat-satellite#get-support'
    get '/links/upgrade/helper'
    assert_redirected_to 'https://access.redhat.com/labs/satelliteupgradehelper'
  end
end
