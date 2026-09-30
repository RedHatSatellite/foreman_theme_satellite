# Hide only standalone documentation actions, preserving inline help content. Keep documentation dictionaries and redirect
# endpoints intact so the links can be restored independently of their targets.
{
  'auth_source_ldaps/_ldap_card_kebab' => "li:has(erb[loud]:contains('documentation_url')), li.divider",
  'auth_source_externals/_external_card_kebab' => "li:has(erb[loud]:contains('documentation_url')), li.divider",
}.each do |virtual_path, selector|
  Deface::Override.new(
    virtual_path: virtual_path,
    name: "satellite_hide_documentation_#{virtual_path.tr('/', '_')}",
    remove: selector
  )
end

Deface::Override.new(
  virtual_path: 'foreman_puppet/config_groups/index',
  name: 'satellite_hide_config_groups_help',
  replace: "erb[silent]:contains('title_actions')",
  text: <<~ERB
    <% title_actions new_link(_('Create Config Group'), { engine: foreman_puppet }, id: 'new_config_group') %>
  ERB
)
