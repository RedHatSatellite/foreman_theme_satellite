require 'rails/generators'
require_relative 'lib/css_compare'
require_relative 'lib/color_changer'

module ForemanThemeSatellite
  class ColorDiffGenerator < Rails::Generators::Base
    class_option :destination_file, required: true
    class_option :source_css, required: true

    def create_color_diff
      replaced = File.read(source_css)

      replaced.gsub!(ForemanThemeSatellite::COLOR_REGEX) do |color|
        ForemanThemeSatellite::COLOR_REPLACEMENT[color] || color
      end

      compare = CssCompare.new(left_filename: source_css, right_css: replaced)
      diff_css = compare.to_css(compare.diff)
      create_file(destination_file, diff_css)
    end

    private

    def source_css
      options['source_css']
    end

    def destination_file
      options['destination_file']
    end
  end
end
