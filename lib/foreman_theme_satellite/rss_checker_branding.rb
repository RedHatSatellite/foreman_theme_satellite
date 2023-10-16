# frozen_string_literal: true

module ForemanThemeSatellite
  module RssCheckerBranding
    extend ActiveSupport::Concern

    def rss_user_agent
      "Satellite/#{ForemanThemeSatellite::SATELLITE_VERSION} (RSS notifications)"
    end
  end
end
