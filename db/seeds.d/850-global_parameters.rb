class CommonParameterSeedHelper
  def self.set_default_global_parameter(name, value)
    param = CommonParameter.find_by_name(name)
    if param.nil?
      CommonParameter.create!(:name => name, :value => value)
    end
  end
end

CommonParameter.without_auditing do
  CommonParameter.skip_permission_check do
    CommonParameterSeedHelper.set_default_global_parameter('enable-epel', 'false')
    CommonParameterSeedHelper.set_default_global_parameter('enable-puppet5', 'true')
  end
end
