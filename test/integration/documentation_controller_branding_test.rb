require 'test_plugin_helper'

class DocumentationControllerBrandingTest < ActionDispatch::IntegrationTest
  setup do
    Rails.stubs(:cache).returns(ActiveSupport::Cache::MemoryStore.new)
    stub_request(:head, %r{https://docs.redhat.com/}).to_return(status: 200)
  end

  def test_docs_redirect_branded
    get "/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts"

    assert_redirected_to "https://docs.redhat.com/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_hosts/index#registering-hosts-by-using-global-registration"
  end

  def test_docs_redirect_inventory_upload_documentation
    get "/links/docs/Administering_Project?chapter=configuring-foreman-server-for-cloud-connection"

    assert_redirected_to "https://docs.redhat.com/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/administering_red_hat_satellite/index#configuring-satellite-server-for-cloud-connection"
  end

  def test_docs_redirect_unknown_chapter
    get "/links/docs/Managing_Hosts"

    assert_redirected_to "https://docs.redhat.com/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_hosts/"
  end
  [404, 410].each do |status|
    define_method("test_docs_falls_back_when_old_page_returns_#{status}") do
      stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_return(status: status)

      get '/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts'

      assert_redirected_to "#{docs_root}/administer-registering-hosts-by-using-global-registration"
    end
  end

  [301, 403, 405, 500].each do |status|
    define_method("test_docs_keeps_old_url_for_status_#{status}") do
      stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_return(status: status)

      get '/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts'

      assert_redirected_to "#{docs_root}/html-single/managing_hosts/index#registering-hosts-by-using-global-registration"
    end
  end

  def test_docs_keeps_old_url_on_timeout
    stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_timeout

    get '/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts'

    assert_redirected_to "#{docs_root}/html-single/managing_hosts/index#registering-hosts-by-using-global-registration"
  end

  def test_manual_fallback_and_cache_shared_across_anchors
    request = stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_return(status: 404)

    get '/links/manual/JobTemplates'
    assert_redirected_to "#{docs_root}/administer-customizing-job-templates"

    get '/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts'
    assert_redirected_to "#{docs_root}/administer-registering-hosts-by-using-global-registration"
    assert_requested request, times: 1
  end

  def test_plugin_documentation_fallback
    stub_request(:head, "#{docs_root}/html-single/provisioning_hosts/index").to_return(status: 404)

    get '/links/plugin_manual', params: { name: 'foreman_discovery' }

    assert_redirected_to "#{docs_root}/administer-discovering-hosts-on-a-network"
  end

  def test_mapping_without_anchor_keeps_html_segment_without_probe
    get '/links/manual/Provisioning'

    assert_redirected_to "#{docs_root}/html-single/provisioning_hosts/index"
    assert_not_requested :head, %r{https://docs.redhat.com/}
  end

  def test_absolute_mapping_is_used_directly_without_probe
    get '/links/manual/GettingHelp'

    assert_redirected_to 'https://access.redhat.com/products/red-hat-satellite/#support'
    assert_not_requested :head, %r{https://docs.redhat.com/}
  end

  def test_custom_documentation_server
    Setting[:satellite_documentation_url] = 'https://knowledge.example.test/portal'
    request = stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_return(status: 404)

    get '/links/manual/JobTemplates'

    assert_redirected_to "#{docs_root}/administer-customizing-job-templates"
    assert_requested request, times: 1
  end

  def test_explicit_fallback_can_use_a_different_category_and_topic_id
    stub_request(:head, "#{docs_root}/html-single/managing_hosts/index").to_return(status: 404)
    path = ['managing_hosts/index#customizing-job-templates', 'configure-remote-job-templates']

    assert_equal "#{docs_root}/configure-remote-job-templates",
      ForemanThemeSatellite::DocumentationLinkResolver.resolve_url(root: docs_root, path: path)
  end

  def test_single_anchored_path_has_no_derived_fallback
    path = 'managing_hosts/index#customizing-job-templates'

    assert_equal "#{docs_root}/html-single/#{path}",
      ForemanThemeSatellite::DocumentationLinkResolver.resolve_url(root: docs_root, path: path)
    assert_not_requested :head, %r{https://docs.redhat.com/}
  end

  private

  def docs_root
    "#{Setting[:satellite_documentation_url]}/en/documentation/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}"
  end
end
