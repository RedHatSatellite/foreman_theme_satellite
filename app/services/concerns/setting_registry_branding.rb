# Responsible for silently overwriting setting's default value.
module SettingRegistryBranding
  def branded_settings
    domain = SETTINGS[:domain]
    @branded_settings ||= {
      'email_reply_address' => "satellite-noreply@#{domain}",
      'email_subject_prefix' => '[satellite]',

      'rss_url' => 'https://www.redhat.com/en/rss/blog/channel/red-hat-satellite',
      'foreman_tasks_troubleshooting_url' => 'https://access.redhat.com/solutions/satellite6-tasks#%{label}',
      'bootdisk_allowed_types' => ['subnet','full_host'],
      'template_sync_commit_msg' => 'Templates export made by a Satellite user'
    }.freeze
  end

  def _add(name, default:, **rest)
    branded_default = branded_settings.fetch(name.to_s, default)
    super(name, default: branded_default, **rest) unless UpstreamOnlySettings::SETTINGS.include?(name.to_s)
  end
end
