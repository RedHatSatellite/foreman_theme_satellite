module RhevHelper
  def rhev_deprecation_alert
    header = _('RHEV integration is deprecated.')
    text = _('On August 31, 2022, Red Hat Virtualization entered the Maintenance Support Phase. The Maintenance Support Phase runs until August 31, 2024, followed by the Extended Life Phase, which runs until August 31, 2026.')
    link = link_to(_('More information'), 'https://access.redhat.com/announcements/6960518', target: '_blank', rel: 'noopener')
    alert = "<strong>#{header}</strong><p>#{text}&nbsp;#{link}</p>"

    content_tag(:div, alert.html_safe, class: 'alert alert-warning')
  end
end
