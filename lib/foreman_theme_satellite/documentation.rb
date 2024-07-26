# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module ForemanThemeSatellite
  module Documentation
    USER_GUIDE_DICTIONARY = {
      # Managing Hosts
      'ForemanRemoteExecution' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts",
      'ExecutingaJob' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts#Configuring_the_Global_capsule_Remote_Execution_Setting_in_satellite_managing-hosts",
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
      'VMwareNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_in_vmware_vmware-provisioning",
      'RHEVNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_on_ovirt_rhv-provisioning",
      'OpenStackNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_openstack_openstack-provisioning",
      'LibvirtNote' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_virtual_machines_on_kvm_kvm-provisioning",
      'EC2' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_in_amazon_ec2_ec2-provisioning",
      'GoogleComputeEngineNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/provisioning_cloud_instances_on_google_compute_engine_gce-provisioning",
      'Networking' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/configuring_networking_provisioning#Adding_a_Subnet_to_Server_provisioning",

      # Puppet Guide
      'FactsandtheENC' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/introducing-configuration-management-using-puppet_managing-configurations-puppet#performing-configuration-management_managing-configurations-puppet",
      'using-config-groups' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/creating-a-puppet-config-group_managing-configurations-puppet",
      'SmartMatchers' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Parameters' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/configuring_puppet_smart_class_parameters_managing-configurations-puppet",
      'Classes' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/importing_puppet_classes_and_environments_managing-configurations-puppet",
      'Environments' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_using_puppet_integration/creating_a_custom_puppet_environment_managing-configurations-puppet",

      # Administering
      'ConfigurationOptions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/",
      'PuppetReports' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/monitoring_resources_admin#Using_the_Project_Content_Dashboard_admin",
      'Mail_Notifications' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/configuring_email_notifications_admin",
      'Realm' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/configuring_external_authentication_satellite#configuring-project-to-manage-the-lifecycle-of-a-host-registered-to-a-freeipa-realm_satellite",
      'Searching' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'RolesandPermissions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/managing_users_and_roles_admin",
      'LDAPAuthentication' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/configuring_external_authentication_satellite#Using_LDAP_satellite",
      'ExternalAuthentication' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/configuring_external_authentication_satellite",
      'Bookmarks' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/searching_and_bookmarking_admin",
      'Policydeploymentoptions' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/compliance-policy-deployment-options_security-compliance",
      'CreatingSCAPcontent' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/configuring_scap_contents_security-compliance",

      # Planning
      'SmartProxies' => "#{ForemanThemeSatellite.documentation_root}/overview_concepts_and_deployment_considerations/major-satellite-components_planning#Capsule-Overview_planning",
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
      'foreman_discovery' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/discovering-hosts-on-a-network_provisioning",
    }.freeze

    # Guide mapping. If no entry is present, it should be assumed that it can
    # be downcased
    # Copied from foreman-documentation's upstream_filename_to_satellite_link.json
    DOCS_GUIDE_MAPPING = {
      'Administering_Project' => 'administering_red_hat_satellite',
      'Configuring_Load_Balancer' => 'configuring_capsules_with_a_load_balancer',
      'Deploying_Project_on_AWS' => 'deploying_red_hat_satellite_on_amazon_web_services',
      'Installing_Proxy' => 'installing_capsule_server',
      'Installing_Server' => 'installing_satellite_server_in_a_connected_network_environment',
      'Installing_Server_Disconnected' => 'installing_satellite_server_in_a_disconnected_network_environment',
      'Managing_Configurations_Ansible' => 'managing_configurations_using_ansible_integration',
      'Managing_Configurations_Puppet' => 'managing_configurations_using_puppet_integration',
      'Managing_Content' => 'managing_content',
      'Managing_Hosts' => 'managing_hosts',
      'Managing_Security_Compliance' => 'managing_security_compliance',
      'Monitoring_Project' => 'monitoring_satellite_performance',
      'Planning_for_Project' => 'overview_concepts_and_deployment_considerations',
      'Provisioning_Hosts' => 'provisioning_hosts',
      'Tuning_Performance' => 'tuning_performance_of_red_hat_satellite',
      'Updating_Project' => 'updating_red_hat_satellite',
      'Upgrading_Project' => "upgrading_connected_red_hat_satellite_to_#{SATELLITE_SHORT_VERSION}",
      'Upgrading_Project_Disconnected' => "upgrading_disconnected_red_hat_satellite_to_#{SATELLITE_SHORT_VERSION}",
    }.freeze

    # An upstream chapter mapping, in case downstream another chapter should be
    # used. The top level key is the upstream guide name where the value is a
    # mapping of upstream chapter to downstream mapping
    DOCS_GUIDE_CHAPTER_MAPPING = {
      'Managing_Hosts' => {
        'registering-a-host_managing-hosts' => 'Registering_Hosts_by_Using_Global_Registration_managing-hosts',
      },
    }.freeze

    DOCS_GUIDE_PAGES = JSON.load_file(File.join(__dir__, 'documentation-toc.json'))

    def self.docs_url(guide, chapter, logger:)
      root = ForemanThemeSatellite.documentation_root
      downstream_guide = DOCS_GUIDE_MAPPING.fetch(guide) do
        logger.debug("Could not find downstream guide for '#{guide}'")
        guide.downcase
      end

      if chapter
        downstream_chapter = DOCS_GUIDE_CHAPTER_MAPPING.fetch(guide, chapter) || chapter

        if (page = DOCS_GUIDE_PAGES[downstream_guide]&.find { |_page, chapters| chapters.include?(downstream_chapter) }&.first)
          "#{root}/#{downstream_guide}/#{page}##{downstream_chapter}"
        else
          logger.warn("Could not find page for chapter '#{downstream_chapter}' in guide '#{downstream_guide}'")
          "#{root}-single/#{downstream_guide}/index##{downstream_chapter}"
        end
      else
        "#{root}/#{downstream_guide}"
      end
      key_values
    end
  end
end
