# frozen_string_literal: true

module ForemanThemeSatellite
  module ScapBulkUploadExtensions
    extend ActiveSupport::Concern

    def security_guide_packages
      packages = super
      packages.unshift('scap-security-guide-satellite')
      packages
    end

    def extract_name_from_file(file)
      # SCAP datastream files are in format of ssg-sat-<OS>-ds.xml
      # We wish to extract the <OS> and create a name of it
      super.gsub('sat-', '')
    end
  end
end
