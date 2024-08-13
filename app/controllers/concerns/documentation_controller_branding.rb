require_relative '../../../lib/foreman_theme_satellite/documentation'

module DocumentationControllerBranding
  extend ActiveSupport::Concern

  def documentation_url(section = nil, options = {})
    url = ''
    unless section.nil?
      dictionary = ForemanThemeSatellite::Documentation::USER_GUIDE_DICTIONARY
      matched_key = dictionary.keys.sort_by(&:length).reverse.find {|key| section.include? key}
      url = dictionary[matched_key] if matched_key
    end
    if url.empty?
      upstream_url = super(section, options)
      url = if (upstream_url =~ /redhat.com/)
              upstream_url
            else
              "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite"
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

  # For new documentation at docs.theforeman.org
  # We do not use flavor downstream, but keeping it here for the same method signature
  # rubocop:disable Lint/UnusedMethodArgument
  def docs_url(guide:, flavor:, chapter: nil)
    ForemanThemeSatellite::Documentation.docs_url(guide, chapter, logger: Foreman::Logging.logger('app'))
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
