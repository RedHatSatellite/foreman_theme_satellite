# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
# Overrides for functions used in helpers.
module ThemeApplicationHelper
  def association_text()
    content_tag(:p, _('When editing a Template, you must assign a list of Operating Systems with which this Template can be used. Optionally, you can restrict a template to a list of Hostgroups or Environments.')) +
      content_tag(:p, _('When a Host requests a template (e.g. during provisioning), Foreman selects the optimal match from the available templates of that type, in the following order:')) +
      (content_tag :ul do
        content_tag(:li, _('Host group and Environment'))
        content_tag(:li, _('Host group only'))
        content_tag(:li, _('Environment only'))
        content_tag(:li, _('Operating system default'))
      end)
    (_('The final entry, Operating System default, can be set by editing the %s page.') % (link_to _('Operating System'), operatingsystems_path)).html_safe
  end
end
