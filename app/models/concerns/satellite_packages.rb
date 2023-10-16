module SatellitePackages
  extend ActiveSupport::Concern
  included do
    old_packages = remove_const(:PACKAGES)
    const_set(:PACKAGES, (old_packages + ['satellite']).freeze)
  end
end

