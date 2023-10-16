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
      if (upstream_url =~ /redhat.com/)
        url = upstream_url
      else
        special_links_pair = ForemanThemeSatellite::Documentation::SPECIAL_LINKS.find { |regex, _val| regex.match(upstream_url) }
        url = special_links_pair[1] if special_links_pair
        url = "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite" if url.empty?
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
end
