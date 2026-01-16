# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module ForemanThemeSatellite
  module Documentation
    USER_GUIDE_DICTIONARY = {
      # Managing Hosts
      'ForemanRemoteExecution' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring-and-setting-up-remote-jobs",
      'ExecutingaJob' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring-and-setting-up-remote-jobs#configuring-the-global-capsule-remote-execution-setting-by-using-web-ui",
      'JobTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring-and-setting-up-remote-jobs#customizing-job-templates",
      'ReportTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/using_report_templates_to_monitor_hosts_managing-hosts",
      'Reports' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/using_report_templates_to_monitor_hosts_managing-hosts",

      # Provisioning Hosts
      'Architectures' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-client-platforms#creating-architectures-by-using-web-ui",
      'Provisioning' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/",
      'InstallationMedia' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-provisioning-content#adding-installation-media-by-using-web-ui",
      'PartitionTables' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-templates-for-provisioning#creating-partition-tables-by-using-web-ui",
      'ProvisioningTemplates' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-templates-for-provisioning#provisioning-templates",
      'OperatingSystems' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-client-platforms#creating-operating-systems-by-using-web-ui",
      'UsingComputeProfiles' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-client-platforms#creating-compute-profiles-by-using-web-ui",
      'ComputeResources' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/",
      'NoVNC' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/using-novnc-to-access-virtual-machines_provisioning",
      'VMwareNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_in_vmware_vmware-provisioning",
      'OpenStackNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_openstack_openstack-provisioning",
      'LibvirtNote' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_on_kvm_kvm-provisioning",
      'EC2' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning-cloud-instances-on-amazon-ec2",
      'GoogleComputeEngineNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_on_google_compute_engine_gce-provisioning",
      'Networking' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/preparing-networking#adding-a-subnet-to-server-by-using-web-ui",

      # Puppet Guide
      'FactsandtheENC' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/introducing-configuration-management-by-using-puppet#performing-configuration-management_managing-configurations-puppet",
      'using-config-groups' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/creating-a-puppet-config-group_managing-configurations-puppet",
      'SmartMatchers' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Parameters' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Classes' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/importing_puppet_classes_and_environments_managing-configurations-puppet",
      'Environments' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/creating_a_custom_puppet_environment_managing-configurations-puppet",

      # Administering
      'ConfigurationOptions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/",
      'PuppetReports' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/monitoring-satellite-resources#Using_the_Project_Content_Dashboard_admin",
      'Mail_Notifications' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/configuring_email_notifications_admin",
      'Realm' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/performing-additional-configuration-on-server_satellite#configuring-project-to-manage-the-lifecycle-of-a-host-registered-to-a-freeipa-realm_satellite",
      'Searching' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'RolesandPermissions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/managing_users_and_roles_admin",
      'LDAPAuthentication' => "#{ForemanThemeSatellite.documentation_root}/configuring_authentication_for_red_hat_satellite_users/configuring-an-ldap-server-as-an-external-identity-provider-for-project_authentication",
      'ExternalAuthentication' => "#{ForemanThemeSatellite.documentation_root}/configuring_authentication_for_red_hat_satellite_users/",
      'Bookmarks' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'Policydeploymentoptions' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/configuring-compliance-policy-deployment-methods_security-compliance#compliance-policy-deployment-options_security-compliance",
      'CreatingSCAPcontent' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/configuring_scap_contents_security-compliance",

      # Planning
      'SmartProxies' => "#{ForemanThemeSatellite.documentation_root}/overview_concepts_and_deployment_considerations/major-satellite-components_planning",
      'Auditing' => "#{ForemanThemeSatellite.documentation_root}/overview_concepts_and_deployment_considerations/glossary-of-terms-used-in-satellite_planning#Audits",

      # Install
      'HTTP(S)Proxy' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/performing-additional-configuration-on-server_satellite#Configuring_Server_with_an_HTTP_Proxy_satellite",

      # Misc
      'GettingHelp' => "https://access.redhat.com/products/red-hat-satellite/#support",

      # Managing Security Compliance
      'Monitoring_Compliance_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/monitoring_compliance_security-compliance",
      'Managing_Compliance_Policies_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/managing_compliance_policies_security-compliance",
      'Configuring_SCAP_Contents_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/configuring_scap_contents_security-compliance",
      'tailoring-xccdf-profiles_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/configuring_scap_contents_security-compliance#tailoring-xccdf-profiles_security-compliance",
      'deploying-compliance-policies_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/deploying-compliance-policies_security-compliance",
    }.freeze

    PLUGINS_DOCUMENTATION = {
      'foreman_azure' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_on_microsoft_azure_resource_manager_azure-provisioning",
      'foreman_discovery' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/discovering-hosts-on-a-network",
    }.freeze

    DOCS_GUIDES_LINKS = {
      'Managing_Content' => {
        'Products_and_Repositories_content-management' => "#{ForemanThemeSatellite.documentation_root}/managing_content/importing_content_content-management#Products_and_Repositories_content-management",
      },
      'Managing_Hosts' => {
        'registering-a-host_managing-hosts' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/registering-hosts-and-setting-up-host-integration_managing-hosts#Registering_Hosts_by_Using_Global_Registration_managing-hosts",
        'setting-minimal-data-collection' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/monitoring-hosts-by-using-red-hat-lightspeed-in-cloud#data-control-settings",
      },
      'Managing_Configurations_Ansible' => {
        'Importing_Ansible_Roles_and_Variables_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_ansible_integration/getting_started_with_ansible_in_satellite_ansible#Importing_Ansible_Roles_and_Variables_ansible",
        'Overriding_Ansible_Variables_in_foreman_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_ansible_integration/getting_started_with_ansible_in_satellite_ansible#Overriding_Ansible_Variables_in_satellite_ansible",
      }
    }.freeze

    def self.flat_docs_guides_links
      nested_to_flat_k_v(nil, DOCS_GUIDES_LINKS).to_h
    end

    private_class_method def self.nested_to_flat_k_v(prefix, source)
      key_values = []
      source.map do |k, v|
        key = "#{prefix}/#{k}"
        if v.is_a?(Hash)
          key_values.concat(nested_to_flat_k_v(key, v))
        else
          key_values.concat([[key, v]])
        end
      end
      key_values
    end
  end
end
