# frozen_string_literal: true
require 'sass'

module ForemanThemeSatellite

  # Semantically compares two css files.
  # returns hash: rule => prop => value
  class CssCompare
    attr_reader :left, :right

    def initialize(left_filename: nil, left_css: nil, right_filename: nil, right_css: nil)
      @left = left_filename ? Sass::Engine.for_file(left_filename, syntax: :scss) : Sass::Engine.new(left_css, syntax: :scss)
      @right = right_filename ? Sass::Engine.for_file(right_filename, syntax: :scss) : Sass::Engine.new(right_css, syntax: :scss)
    end

    def diff
      result_hash = {}

      right_hash = rules_hash(right)

      rules_hash(left).each do |rule, props|
        right_props = right_hash[rule]
        unless props
          result_hash[rule] = props
          next
        end

        diffed_props = props_diff(props_hash(props), props_hash(right_props))

        result_hash[rule] = diffed_props unless diffed_props.empty?
      end

      result_hash
    end

    def to_css(diff)
      diff.map do |rule, props|
        [
          "#{rule} {",
          to_properties_css(props, '  '),
          '}'
        ]
      end.flatten.join("\n")
    end

    private

    def rules_hash(engine)
      root = engine.to_tree

      Hash[
        root.children.select { |c| c.is_a? Sass::Tree::RuleNode }.map do |c|
          raise "Rule has too many names: #{c.to_sass}" if c.rule.length > 1
          [c.rule[0], c.children]
        end
      ]
    end

    def props_hash(props)
      Hash[
        props.reject { |c| c.is_a? Sass::Tree::CommentNode }.map do |prop|
          raise "property has too many names: #{prop.to_sass}" if prop.name.length > 1
          [
            prop.name[0],
            (prop.value[0].is_a? String)? prop.value[0] : prop.value[0].to_sass
          ]
        end
      ]
    end

    def props_diff(left, right)
      right.reject { |k, v| left[k] == v }
    end

    def to_properties_css(props, indent)
      props.map do |prop, val|
        "#{indent}#{to_property_css(prop, val)}"
      end.join("\n")
    end

    def to_property_css(property, value)
      "#{property}: #{value};"
    end
  end
end
