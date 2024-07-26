require 'test_plugin_helper'

class DocumentationControllerBrandingTest < ActionDispatch::IntegrationTest
  def test_docs_redirect_branded
    get "/links/docs/Managing_Hosts?chapter=registering-a-host_managing-hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_hosts/registering_hosts_to_server_managing-hosts#Registering_Hosts_by_Using_Global_Registration_managing-hosts"
  end

  def test_docs_dynamically_generated
    get "/links/docs/Managing_Content?chapter=Products_and_Repositories_content-management"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_content/importing_content_content-management#Products_and_Repositories_content-management"
  end

  def test_docs_with_mapped_guide
    get "/links/docs/Managing_Configurations_Ansible?chapter=Importing_Ansible_Roles_and_Variables_ansible"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_configurations_using_ansible/getting_started_with_ansible_in_satellite_ansible_integration#Importing_Ansible_Roles_and_Variables_ansible"
  end

  def test_docs_chapter_does_not_exist
    get "/links/docs/Managing_Content?chapter=does-not-exist"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html-single/managing_content/index#does-not-exist"
  end

  def test_docs_redirect_unknown_chapter
    get "/links/docs/Managing_Hosts"

    assert_redirected_to "https://docs.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite.documentation_version}/html/managing_hosts/"
  end

  def test_docs_guide_chapter_mapping
    logger = mock

    ForemanThemeSatellite::Documentation::DOCS_GUIDE_CHAPTER_MAPPING.each do |guide, chapters|
      chapters.each_key do |chapter|
        url = ForemanThemeSatellite::Documentation.docs_url(guide, chapter, logger: logger)
        assert_not_includes(url, 'html-single')
      end
    end
  end

  def test_many
    {
      'Managing_Content' => {
        'Products_and_Repositories_content-management' => "#{ForemanThemeSatellite.documentation_root}/managing_content/importing_content_content-management#Products_and_Repositories_content-management",
      },
      'Managing_Configurations_Ansible' => {
        'Importing_Ansible_Roles_and_Variables_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_ansible_integration/getting_started_with_ansible_in_satellite_ansible#Importing_Ansible_Roles_and_Variables_ansible",
        'Overriding_Ansible_Variables_in_foreman_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_ansible_integration/getting_started_with_ansible_in_satellite_ansible#Overriding_Ansible_Variables_in_satellite_ansible",
      },
    }.each do |guide, chapters|
      chapters.each do |chapter, expected|
        get "/links/docs/#{guide}?chapter=#{chapter}"
        assert_redirected_to expected
      end
    end
  end
end
