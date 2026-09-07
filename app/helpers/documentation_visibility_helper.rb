# Hide Rails documentation controls without changing their URL helpers or redirects.
module DocumentationVisibilityHelper
  def help_button
    ''
  end

  def documentation_button(*args, **options)
    ''
  end
end
