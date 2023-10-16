require 'test_plugin_helper'

class RssAgentTest < ActiveSupport::TestCase
  describe 'Branded rss agent' do
    test 'calls rss feed with a branded user agent' do
      stub_request(:get, //)
        .with(headers: { 'User-Agent' => /Satellite/ })

      UINotifications::RssNotificationsChecker.new.send :load_rss_feed
    end
  end
end
