# frozen_string_literal: true

module ForemanThemeSatellite
  COLOR_REGEX = /#([0-9A-Fa-f]){3}((?=[^[:alnum:]])|([0-9A-Fa-f]){3,5})/i

  # This color translation is copied from previous colors.scss file.
  # When the same source color was translated to multiple destinations,
  # one of the conflicting pairs was commented out and left for future
  # reference.
  # Each line is commented by the corresponding parameter name.
  COLOR_REPLACEMENT = {
    '#005c7e' => '#393F44', # $primary_color
    '#0187b6' => '#5F666C',   # $border_color
    # '#005c7e' => '#CC0000',   # $brand_color
    '#0072a0' => '#474C51',   # $primary_gradient_start
    # '#0072a0' => '#393F44', # $primary_gradient_end
    '#005b7e' => '#72757A',   # $selected_gradient_start
    # '#005b7e' => '#5c6165', # $hover_gradient_start
    '#006289' => '#64686C',   # $selected_gradient_end
    # '#006289' => '#4b5053'  # $hover_gradient_end
    '#024d6c' => '#393F44',   # $nav-pf-vertical-bg-color
    '#026991' => '#474C51',   # $nav-pf-vertical-active-bg-color
    '#01749d' => '#202020'    # $topbar-default-color
  }.freeze
end
