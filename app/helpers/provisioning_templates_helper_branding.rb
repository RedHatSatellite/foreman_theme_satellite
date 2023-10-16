module ProvisioningTemplatesHelperBranding
  def link_to_if_authorized(name, options = {}, html_options = {})
    return super unless name.is_a?(ProvisioningTemplate)
    return super unless ProvisioningTemplatesControllerBranding::SUPPORTED_PROVISIONING_TEMPLATES.include?(name.name)

    image_tag(
      'foreman_theme_satellite/Redhat.png',
      class: 'prov-brand-img',
      title: _('Supported by Red Hat')
    ).safe_concat(super)
  end
end
