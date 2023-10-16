module SettingBranding
  extend ActiveSupport::Concern
  class_methods do
    def replace_keywords(keyword)
      keyword&.gsub! '$VERSION', ForemanThemeSatellite::SATELLITE_VERSION
      super
    end

    def [](name)
      if UpstreamOnlySettings::SETTINGS.include?(name.to_s)
        Rails.logger.debug "Setting '#{name}' is not available in Satellite; ignoring"
        return nil
      end
      super
    end
  end
end
