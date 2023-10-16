# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
module ForemanThemeSatellite
  module Documentation
    USER_GUIDE_DICTIONARY = {
      # Ansible
      'ImportingRoles' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_ansible_integration_in_red_hat_satellite/getting_started_with_ansible_in_satellite_ansible#Importing_Ansible_Roles_and_Variables_ansible",
      'Variables' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_ansible_integration_in_red_hat_satellite/getting_started_with_ansible_in_satellite_ansible#Overriding_Ansible_Variables_in_satellite_ansible",

      # Managing Hosts
      'ForemanRemoteExecution' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts",
      'ExecutingaJob' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts#configuring-the-global-smartproxy-remote-execution-setting_managing-hosts",
      'JobTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts#setting-up-job-templates_managing-hosts",
      'ReportTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/using_report_templates_to_monitor_hosts_managing-hosts",
      'Reports' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/using_report_templates_to_monitor_hosts_managing-hosts",

      # Provisioning Hosts
      'Architectures' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#creating-architectures_provisioning",
      'Provisioning' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/",
      'InstallationMedia' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#adding-installation-media_provisioning",
      'PartitionTables' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#creating-partition-tables_provisioning",
      'ProvisioningTemplates' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#provisioning-templates_provisioning",
      'OperatingSystems' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#creating-operating-systems_provisioning",
      'UsingComputeProfiles' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#creating-compute-profiles_provisioning",
      'ComputeResources' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/",
      'NoVNC' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_provisioning_resources_provisioning#using-novnc-to-access-virtual-machines_provisioning",
      'VMwareNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_in_vmware_provisioning",
      'RHEVNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_on_ovirt_provisioning",
      'OpenStackNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_openstack_provisioning",
      'LibvirtNote' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_on_kvm_provisioning",
      'EC2' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_in_amazon_ec2_provisioning",
      'GoogleComputeEngineNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_on_google_compute_engine_provisioning",
      'Networking' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_networking_provisioning#Adding_a_Subnet_to_Server_provisioning",

      # Puppet Guide
      'FactsandtheENC' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/introducing-configuration-management-using-puppet_managing-configurations-puppet#performing-configuration-management_managing-configurations-puppet",
      'using-config-groups' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/creating-a-puppet-config-group_managing-configurations-puppet",
      'SmartMatchers' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Parameters' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Classes' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/importing_puppet_classes_and_environments_managing-configurations-puppet",
      'Environments' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration_in_red_hat_satellite/creating_a_custom_puppet_environment_managing-configurations-puppet",

      # Administering
      'ConfigurationOptions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/",
      'PuppetReports' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/monitoring_resources_admin#Using_the_Project_Content_Dashboard_admin",
      'Mail_Notifications' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/configuring_email_notifications_admin",
      'Realm' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/configuring_external_authentication_satellite#External_Authentication_for_Provisioned_Hosts_satellite",
      'Searching' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'RolesandPermissions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/managing_users_and_roles_admin",
      'LDAPAuthentication' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/configuring_external_authentication_satellite#Using_LDAP_satellite",
      'Bookmarks' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'Policydeploymentoptions' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance#Managing_Compliance_Policies_security-compliance",
      'CreatingSCAPcontent' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/managing_security_compliance_admin#running-a-security-compliance-scan-on-demand_admin",

      # Planning
      'SmartProxies' => "#{ForemanThemeSatellite.documentation_root}/satellite_overview_concepts_and_deployment_considerations/chap-documentation-architecture_guide-capsule_server_overview",
      'Auditing' => "#{ForemanThemeSatellite.documentation_root}/satellite_overview_concepts_and_deployment_considerations/appe-architecture_guide-glossary_of_terms#varl-Glossary_of_Terms-Audits",

      # Install
      'HTTP(S)Proxy' => "#{ForemanThemeSatellite.documentation_root}//installing_satellite_server_in_a_connected_network_environment/performing-additional-configuration#Configuring_Server_with_an_HTTP_Proxy_satellite",

      # Misc
      'GettingHelp' => "https://access.redhat.com/products/red-hat-satellite/#support",
    }.freeze

    PLUGINS_DOCUMENTATION = {
      'foreman_azure' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_on_microsoft_azure_resource_manager_provisioning",
      'foreman_discovery' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_the_discovery_service_provisioning",
    }.freeze

    SPECIAL_LINKS = [
      [/docs\.theforeman\.org\/.*?\/Managing_Hosts\/.*?registering-a-host.*?managing-hosts/i, "#{ForemanThemeSatellite.documentation_root}/managing_hosts/registering_hosts_to_server_managing-hosts#Registering_Hosts_managing-hosts"],
    ]
  end
end
