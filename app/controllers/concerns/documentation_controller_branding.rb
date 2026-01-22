require_relative '../../../lib/foreman_theme_satellite/documentation'

module DocumentationControllerBranding
  extend ActiveSupport::Concern

  def documentation_url(section = nil, options = {})
    url = ''
    unless section.nil?
      dictionary = ForemanThemeSatellite::Documentation::USER_GUIDE_DICTIONARY
      matched_key = dictionary.keys.sort_by(&:length).reverse.find {|key| section.include? key}
      url = "#{documentation_root}/#{dictionary[matched_key]}" if matched_key
    end
    if url.empty?
      upstream_url = super(section, options)
      url = if (upstream_url =~ /redhat.com/)
              upstream_url
            else
              documentation_root_url
            end
    end
    url
  end

  def plugin_documentation_url
    ForemanThemeSatellite::Documentation::PLUGINS_DOCUMENTATION[plugin_documentation_params[:name]] || super
  end

  def wiki_url(section: '')
    documentation_url(section)
  end

  def support_url
    'https://access.redhat.com/products/red-hat-satellite#get-support' # This is not included in RHOKP
  end

  # For new documentation at docs.theforeman.org
  # We do not use flavor downstream, but keeping it here for the same method signature
  # rubocop:disable Lint/UnusedMethodArgument
  def docs_url(guide:, flavor:, chapter: nil)
    url = ForemanThemeSatellite::Documentation::DOCS_GUIDES_LINKS.dig(guide, chapter)
    url ? "#{documentation_root}/#{url}" : "#{documentation_root}/#{guide.downcase}/#{chapter}"
  end

  def upgrade_url(section)
    case section
    when 'documentation'
      "#{unversioned_documentation_root}#Upgrade"
    when 'helper'
      'https://access.redhat.com/labs/satelliteupgradehelper' # This is not included in RHOKP
    end
  end

  def documentation_root_url
    "#{unversioned_documentation_root}/#{ForemanThemeSatellite.documentation_version}"
  end

  def documentation_root
    "#{unversioned_documentation_root}/#{ForemanThemeSatellite.documentation_version}/html-single"
  end

  def unversioned_documentation_root
    "#{Setting[:satellite_documentation_url]}/documentation/en-us/red_hat_satellite"
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
