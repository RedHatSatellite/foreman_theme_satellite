require 'test_plugin_helper'

class SmartProxyOverrideTest < ActionController::TestCase
  tests SmartProxiesController
  test "index page" do
    get :index, session: set_session_user

    assert_response :success
    assert_match(/Capsules/, response.body)
    assert_match(/Create Capsule/, response.body)
  end

  test 'create new page' do
    get :index, session: set_session_user

    assert_select("a[href='#{new_smart_proxy_path}']") do |link|
      assert_equal 'Create Capsule', link.text
    end
  end
end
