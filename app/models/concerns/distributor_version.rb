module DistributorVersion
  extend ActiveSupport::Concern

  included do
    const_set(:DISTRIBUTOR_VERSION, "sat-#{ForemanThemeSatellite::SATELLITE_SHORT_VERSION}".freeze)
  end
end
