# frozen_string_literal: true

# Overrides for functions used in helpers.
module ThemeLayoutHelper
  def title(page_title, page_header = nil)
    content_for(:content) do
      react_component 'Helmet', title: page_title.to_s
    end

    super
  end

  def layout_data
    super.merge(
      logo: image_path("foreman_theme_satellite/header_logo.svg", :class => "header-logo")
    )
  end
end
