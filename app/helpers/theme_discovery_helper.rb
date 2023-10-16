# frozen_string_literal: true

# Overrides for functions used in helpers.
module ThemeDiscoveryHelper
  # This override should be deprecated once discovery moves to use external links controller.
  # Tracked upstream under https://projects.theforeman.org/issues/33231
  def discovery_doc_url
    ForemanThemeSatellite::Documentation::PLUGINS_DOCUMENTATION['foreman_discovery']
  end
end
