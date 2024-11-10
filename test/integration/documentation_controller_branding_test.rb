require 'test_plugin_helper'

class DocumentationControllerBrandingTest < ActionDispatch::IntegrationTest
  def test_docs_redirect_branded
    get "/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_hosts/registering-hosts-and-setting-up-host-integration_managing-hosts#Registering_Hosts_by_Using_Global_Registration_managing-hosts"
  end

  def test_docs_redirect_unknown_chapter
    get "/links/docs/Managing_Hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_hosts/"
  end
end
