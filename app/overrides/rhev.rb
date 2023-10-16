Deface::Override.new(virtual_path: 'compute_resources/form/_ovirt',
  name: 'rhev_new',
  insert_before: "erb[loud]:contains(':url')",
  partial: 'foreman_theme_satellite/rhev/form')

Deface::Override.new(virtual_path: 'compute_resources/show/_ovirt',
  name: 'rhev_show',
  insert_after: 'tr:nth-child(4)',
  partial: 'foreman_theme_satellite/rhev/show')

Deface::Override.new(virtual_path: 'compute_resources_vms/form/ovirt/_base',
  name: 'rhev_vm',
  insert_after: "erb[loud]:contains(':keyboard_layout')",
  partial: 'foreman_theme_satellite/rhev/form')
