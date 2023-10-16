module ProvisioningTemplatesControllerBranding
  extend ActiveSupport::Concern

  SUPPORTED_PROVISIONING_TEMPLATES = [
    'ansible_provisioning_callback',
    'ansible_tower_callback_script',
    'ansible_tower_callback_service',
    'Atomic Kickstart default',
    'AutoYaST default',
    'AutoYaST default iPXE',
    'AutoYaST default PXELinux',
    'AutoYaST default user data',
    'AutoYaST SLES default',
    'blacklist_kernel_modules',
    'Boot disk Grub2 EFI - generic host',
    'Boot disk iPXE - generic host',
    'Boot disk iPXE - generic static host',
    'Boot disk iPXE - host',
    'built',
    'CloudInit default',
    'create_users',
    'csr_attributes.yaml',
    'Discovery Red Hat kexec',
    'efibootmgr_netboot',
    'eject_cdrom',
    'epel',
    'fips_packages',
    'fix_hosts',
    'freeipa_register',
    'Global Registration',
    'Grubby default',
    'http_proxy',
    'insights',
    'iPXE default local boot',
    'iPXE global default',
    'iPXE intermediate script',
    'Kickstart default',
    'Kickstart default finish',
    'Kickstart default iPXE',
    'Kickstart default PXEGrub',
    'Kickstart default PXEGrub2',
    'Kickstart default PXELinux',
    'Kickstart default user data',
    'kickstart_ifcfg_bonded_interface',
    'kickstart_ifcfg_bond_interface',
    'kickstart_ifcfg_generic_interface',
    'kickstart_ifcfg_get_identifier_names',
    'kickstart_kernel_options',
    'kickstart_networking_setup',
    'Kickstart oVirt-RHVH',
    'Kickstart oVirt-RHVH PXELinux',
    'kickstart_rhsm',
    'Linux host_init_config default',
    'ntp',
    'puppet.conf',
    'puppetlabs_repo',
    'puppet_setup',
    'pxegrub2_chainload',
    'PXEGrub2 default local boot',
    'pxegrub2_discovery',
    'PXEGrub2 global default',
    'pxegrub2_mac',
    'pxegrub_chainload',
    'PXEGrub default local boot',
    'pxegrub_discovery',
    'PXEGrub global default',
    'PXELinux chain iPXE',
    'PXELinux chain iPXE UNDI',
    'pxelinux_chainload',
    'PXELinux default local boot',
    'PXELinux default memdisk',
    'pxelinux_discovery',
    'PXELinux global default',
    'redhat_register',
    'remote_execution_ssh_keys',
    'schedule_reboot',
    'UserData default',
    'UserData open-vm-tools',
    'yum_proxy'
  ].freeze

  module Overrides
    def index
      return super if Setting[:show_unsupported_templates]

      @templates = super
      @templates = @templates.where(name: ProvisioningTemplatesControllerBranding::SUPPORTED_PROVISIONING_TEMPLATES)
    end
  end

  included do
    prepend Overrides
  end
end
