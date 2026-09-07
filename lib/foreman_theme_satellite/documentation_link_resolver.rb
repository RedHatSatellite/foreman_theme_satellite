# frozen_string_literal: true

require 'net/http'
require_relative 'documentation'

module ForemanThemeSatellite
  module DocumentationLinkResolver
    def self.resolve_url(root:, path:)
      path, topic = Array(path)
      return path if path.start_with?('http://', 'https://')

      old_url = "#{root}/html-single/#{path}"
      return old_url unless topic

      # Cache per page: fragments are not sent to the documentation server.
      page_url = old_url.split('#', 2).first
      missing = Rails.cache.fetch(['satellite_documentation_missing', page_url], expires_in: 5.minutes) do
        missing_page?(page_url)
      end
      missing ? "#{root}/#{topic}" : old_url
    end

    private_class_method def self.missing_page?(url)
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', open_timeout: 2, read_timeout: 2) do |http|
        http.max_retries = 0
        response = http.request(Net::HTTP::Head.new(uri.request_uri))
        %w[404 410].include?(response.code)
      end
    rescue Timeout::Error, SocketError, SystemCallError, IOError, OpenSSL::SSL::SSLError, Net::HTTPBadResponse, Net::ProtocolError
      false
    end
  end
end
