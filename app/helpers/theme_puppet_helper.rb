# frozen_string_literal: true

# Overrides for functions used in helpers.
module ThemePuppetHelper
  def extraction_warning_puppet_classes_management
    _("Puppet Classes management is deprecated and will be removed in Satellite 6.11")
  end

  def extraction_warning_config_groups
    _("Config Groups are deprecated and will be removed in Satellite 6.11")
  end

  def extraction_warning_puppet_environments
    _("Puppet Environments management is deprecated and will be removed in Satellite 6.11")
  end

  def extraction_warning_smart_class_parameters
    _("Smart Class Parameters management is deprecated and will be removed in Satellite 6.11")
  end

  def extraction_warning_puppet_enc
    _("Puppet ENC is deprecated and will be removed in Satellite 6.11")
  end
end
