require 'fast_gettext'
require_relative 'branded_words'

module ForemanThemeSatellite
  # This repository is a wrapper above other repository,
  # it replaces branded words with their downstream counterparts.
  class ReplacerRepository < ::FastGettext::TranslationRepository::Base
    def initialize(old_repo)
      @repo = old_repo
    end

    def pluralisation_rule
      @repo.pluralisation_rule
    end

    def available_locales
      @repo.available_locales
    end

    def [](key)
      original = @repo[key]
      val = original || key
      return original unless val.is_a? String

      val = val.dup if val

      replaced = replace_string(val)

      replaced == val ? original : replaced
    end

    def plural(*keys)
      @repo.plural(*keys)
    end

    def reload
      @repo.reload
    end

    private

    # 'babcb'.split(/b/, -1) => ['', 'a', 'c', ''].join('z') => 'zazcz'
    def replace_string(val)
      return '' if val.empty?

      ForemanThemeSatellite::FOREMAN_BRAND.each do |foreman_word, value|
        parts = val.split(foreman_word, -1)
        next if parts.size == 1 # no match, try the next word

        parts = parts.map { |part| replace_string(part) }
        return parts.join(value)
      end

      val # no match found at all
    end
  end
end
