module ForemanThemeSatellite
  class Lifecycle
    class << self
      # rubocop:disable Metrics/AbcSize
      def lifecycle_data(version)
        metadata_path = ::ForemanThemeSatellite::LIFECYCLE_METADATA_PATH

        lifecycle_data = { current_version: version }

        return lifecycle_data unless File.exist?(metadata_path)

        version = Foreman::Version.new(version)

        yaml = YAML.load_file(metadata_path)
        raise "Unexpected lifecycle metadata file version '#{version}'" unless yaml['version'] == '1'

        eol = yaml['releases'].fetch("#{version.major}.#{version.minor}", {})['end_of_life']
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
