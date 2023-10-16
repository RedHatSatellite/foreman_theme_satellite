require 'test_plugin_helper'
require 'integration_test_helper'

class RealmOverrideIntegrationTest < ActionDispatch::IntegrationTest
  test "create new page" do
    assert_new_button(realms_path,"Create Realm",new_realm_path)
    fill_in "realm_name", :with => "EXAMPLE.COM"
    select "Red Hat Identity Management", :from => "realm_realm_type"
    select "Realm Proxy", :from => "realm_realm_proxy_id"
    assert_submit_button(realms_path)
    assert page.has_link? 'EXAMPLE.COM'
  end
end
