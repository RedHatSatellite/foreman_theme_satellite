require_relative '../migrate/20180605150932_deprecate_satellite_templates'

module ProvisioningTemplateSeedExtensions
  extend ActiveSupport::Concern

  included do
    after_create :move_deprecated_defaults
  end

  def move_deprecated_defaults
    return unless (old_name = ForemanThemeSatellite::DEPRECATED_TEMPLATES.key(name))

    old_template = ProvisioningTemplate.unscoped.find_by(name: 'DEPRECATED ' + old_name)
    return unless old_template
    old_template.os_default_templates.update_all(provisioning_template_id: id)

    migration = DeprecateSatelliteTemplates.new
    migration.copy_template_combinations(old_template, self)
    migration.copy_operatingsystems(old_template, self)
    save!
  end
end

ProvisioningTemplate.include ProvisioningTemplateSeedExtensions
