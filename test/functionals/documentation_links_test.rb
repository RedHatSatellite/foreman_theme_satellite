require 'test_plugin_helper'
require_relative '../../lib/foreman_theme_satellite/documentation'

require 'net/http'

class DocumentationLinksTest < ActiveSupport::TestCase
  setup do
    WebMock.allow_net_connect!
  end

  teardown do
    WebMock.disable_net_connect!
  end

  ForemanThemeSatellite::Documentation::USER_GUIDE_DICTIONARY.each do |key, doc_address|
    test "#{key} entry is valid" do
      skip('Skip Managing_Compliance_Policies check until 6.14 docs published') if doc_address.include?('Managing_Compliance_Policies_security-compliance')

      uri = URI(doc_address)
      res = Net::HTTP.get_response(uri)

      # it can be either 200 or 302
      refute_equal '404', res.code, "Documentation link #{doc_address} was not found"
    end
  end

  ForemanThemeSatellite::Documentation::PLUGINS_DOCUMENTATION.each do |key, doc_address|
    test "#{key} entry is valid" do
      uri = URI(doc_address)
      res = Net::HTTP.get_response(uri)

      # it can be either 200 or 302
      refute_equal '404', res.code, "Documentation link #{doc_address} was not found"
    end
  end

  ForemanThemeSatellite::Documentation::SPECIAL_LINKS.each do |key, doc_address|
    test "#{key} entry is valid" do
      uri = URI(doc_address)
      res = Net::HTTP.get_response(uri)

      # it can be either 200 or 302
      refute_equal '404', res.code, "Documentation link #{doc_address} was not found"
    end
  end
end
