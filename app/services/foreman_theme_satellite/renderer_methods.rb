# frozen_string_literal: true

module ForemanThemeSatellite
  module RendererMethods
    extend ActiveSupport::Concern
    extend ApipieDSL::Module

    apipie :class, 'Macros related to Satellite branding' do
      name 'Foreman Theme Satellite'
      sections only: %w[all jobs]
    end

    apipie :method, 'Returns a short version of Satellite' do
      desc 'Returns a string representing the short version (X.Y) of Satellite'
      returns String
      example 'product_short_version # => "6.12"'
    end
    def product_short_version
      ForemanThemeSatellite::SATELLITE_SHORT_VERSION
    end
  end
end
