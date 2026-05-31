require 'test_plugin_helper'

class DocumentationControllerBrandingTest < ActionDispatch::IntegrationTest
  def test_docs_redirect_branded
    get "/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_hosts/index#registering-hosts-by-using-global-registration"
  end

  def test_docs_redirect_inventory_upload_documentation
    get "/links/docs/Managing_Hosts?chapter=configuring-foreman-server-for-cloud-connection"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_hosts/index#configuring-satellite-server-for-cloud-connection"
  end

  def test_docs_redirect_unknown_chapter
    get "/links/docs/Managing_Hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_hosts/"
  end
end
