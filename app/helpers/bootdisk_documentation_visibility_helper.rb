module BootdiskDocumentationVisibilityHelper
  def bootdisk_help_link
    ''
  end

  def bootdisk_title_action_buttons(actions)
    visible_actions = actions.reject(&:blank?)
    visible_actions.pop while visible_actions.last == divider
    super(visible_actions)
  end
end
