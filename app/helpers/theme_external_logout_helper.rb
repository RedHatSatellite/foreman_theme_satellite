# frozen_string_literal: true

# Overrides for functions used in helpers.
module ThemeExternalLogoutHelper
  def external_logout_props
    super.merge(
      logoSrc: image_path('foreman_theme_satellite/login_logo.svg')
    )
  end
end
