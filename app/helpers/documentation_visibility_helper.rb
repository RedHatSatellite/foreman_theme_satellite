# Hide Rails documentation controls without changing their URL helpers or redirects.
module DocumentationVisibilityHelper
  DOCUMENTATION_URL_TO_REMOVE = '#satellite-documentation-link-to-remove'.freeze
  DOCUMENTATION_ELEMENT_TO_REMOVE_CLASS = 'docs-element-to-remove'.freeze
  DOCUMENTATION_SECTIONS_TO_REMOVE = %w[
    4.1.1LDAPAuthentication
    5.7ExternalAuthentication
  ].freeze

  def help_button
    ''
  end

  def documentation_button(*_args, **_options)
    ''
  end

  def documentation_url(section = nil, *args, **options)
    return DOCUMENTATION_URL_TO_REMOVE if DOCUMENTATION_SECTIONS_TO_REMOVE.include?(section.to_s)

    super
  end

  def link_to(name = nil, options = nil, html_options = nil, &block)
    link_options = block_given? ? name : options
    return tag.div(class: DOCUMENTATION_ELEMENT_TO_REMOVE_CLASS) if link_options == DOCUMENTATION_URL_TO_REMOVE

    super
  end
end
