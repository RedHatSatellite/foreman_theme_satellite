module ForemanThemeSatellite
  class Lifecycle
    class << self
      def metadata
        metadata_path = ::ForemanThemeSatellite::LIFECYCLE_METADATA_PATH
        File.exist?(metadata_path) ? YAML.load_file(metadata_path) : {}
      end

      # rubocop:disable Metrics/AbcSize
      def lifecycle_data(version)
        yaml = metadata
        parsed = Foreman::Version.new(version)
        lifecycle_data = { current_version: version, short_version: "#{parsed.major}.#{parsed.minor}" }

        return lifecycle_data if yaml.empty?

        raise "Unexpected lifecycle metadata file version '#{yaml['version']}'" unless yaml['version'] == '1'

        eol = yaml['releases'].fetch(lifecycle_data[:short_version], {})['end_of_life']
        lifecycle_data[:end_of_life] = Time.find_zone('UTC').parse(eol) if eol
        lifecycle_data[:status] = if lifecycle_data[:end_of_life].nil?
                                    nil
                                  elsif lifecycle_data[:end_of_life] < Time.zone.now
                                    'danger'
                                  elsif lifecycle_data[:end_of_life] < 6.months.after
                                    'warning'
                                  end

        lifecycle_data
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
