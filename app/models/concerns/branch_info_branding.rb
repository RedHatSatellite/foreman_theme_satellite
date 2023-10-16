module BranchInfoBranding
  def core_app_name
    'Satellite'
  end

  def core_app_version
    Foreman::Version.new(ForemanThemeSatellite::SATELLITE_VERSION)
  end
end
