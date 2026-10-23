Deface::Override.new(
  virtual_path: 'foreman_puppet/config_groups/welcome',
  name: 'satellite_hide_config_groups_documentation',
  replace: "erb[loud]:contains('EmptyState')",
  text: <<~ERB
    <%= react_component('EmptyState', {
                                        :icon => 'object-group',
                                        :iconType => 'fa',
                                        :header => _('Config Groups'),
                                        :description => description,
                                        :action => action
                                      }) %>
  ERB
)

Deface::Override.new(
  virtual_path: 'foreman_puppet/environments/welcome',
  name: 'satellite_hide_environments_documentation',
  replace: "erb[loud]:contains('WelcomeEnv')",
  text: <<~ERB
    <%= react_component('SatelliteWelcomeEnv', {canCreate: authorized_for(action: :new)}) %>
  ERB
)
