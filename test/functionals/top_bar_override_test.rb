require 'test_plugin_helper'
require 'integration_test_helper'

class TopBarOverrideIntegrationTest < ActionDispatch::IntegrationTest
  test "top bar links" do
    skip("Needs to be adapted to new layout")
    visit root_path
    within("nav.navbar-pf-vertical .navbar-brand") do
      assert page.has_link?(:href => "/")
    end
    within("#vertical-nav") do
      assert page.has_link?("Dashboard", :href => "/")
      assert page.has_link?("All Hosts", :href => "/hosts")
      assert page.has_link?("Config Management", :href => "/config_reports?search=eventful+%3D+true")
      assert page.has_link?("Facts", :href => "/fact_values")
      assert page.has_link?("Audits", :href => "/audits")
      assert page.has_link?("Statistics", :href => "/statistics")
      assert page.has_link?("Trends", :href => "/trends")
    end
  end

end
