# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module ForemanThemeSatellite
  module Documentation
    USER_GUIDE_DICTIONARY = {
      # Managing Hosts
      'ForemanRemoteExecution' => "managing_hosts/index#configuring-and-setting-up-remote-jobs",
      'ExecutingaJob' => "managing_hosts/index#configuring-the-global-capsule-remote-execution-setting-by-using-web-ui",
      'JobTemplates' => "managing_hosts/index#customizing-job-templates",
      'ReportTemplates' => "managing_hosts/index#Using_Report_Templates_to_Monitor_Hosts_managing-hosts",
      'Reports' => "managing_hosts/index#Using_Report_Templates_to_Monitor_Hosts_managing-hosts",

      # Provisioning Hosts
      'Architectures' => "provisioning_hosts/index#creating-architectures-by-using-web-ui",
      'Provisioning' => "provisioning_hosts/index",
      'InstallationMedia' => "provisioning_hosts/index#adding-installation-media-by-using-web-ui",
      'PartitionTables' => "provisioning_hosts/index#creating-partition-tables-by-using-web-ui",
      'ProvisioningTemplates' => "provisioning_hosts/index#provisioning-templates",
      'OperatingSystems' => "provisioning_hosts/index#creating-operating-systems-by-using-web-ui",
      'UsingComputeProfiles' => "provisioning_hosts/index#creating-compute-profiles-by-using-web-ui",
      'ComputeResources' => "provisioning_hosts/index",
      'NoVNC' => "provisioning_hosts/index#using-novnc-to-access-virtual-machines_provisioning",
      'VMwareNotes' => "provisioning_hosts/index#Provisioning_Virtual_Machines_in_VMware_vmware-provisioning",
      'OpenStackNotes' => "provisioning_hosts/index#Provisioning_Cloud_Instances_OpenStack_openstack-provisioning",
      'LibvirtNote' => "provisioning_hosts/index#Provisioning_Virtual_Machines_on_KVM_kvm-provisioning",
      'EC2' => "provisioning_hosts/index#provisioning-cloud-instances-on-amazon-ec2",
      'GoogleComputeEngineNotes' => "provisioning_hosts/index#Provisioning_Cloud_Instances_on_Google_Compute_Engine_gce-provisioning",
      'Networking' => "provisioning_hosts/index#adding-a-subnet-to-server-by-using-web-ui",

      # Puppet Guide
      'FactsandtheENC' => "managing_configurations_by_using_puppet_integration/index#high-level-steps-for-configuration-management-with-puppet",
      'Parameters' => "managing_configurations_by_using_puppet_integration/index#Configuring_Puppet_Smart_Class_Parameters_managing-configurations-puppet",

      # Administering
      'ConfigurationOptions' => "administering_red_hat_satellite/index",
      'PuppetReports' => "administering_red_hat_satellite/index#Using_the_Project_Content_Dashboard_admin",
      'Mail_Notifications' => "administering_red_hat_satellite/index#Configuring_Email_Notifications_admin",
      'Realm' => "installing_satellite_server_in_a_connected_network_environment/index#configuring-project-to-manage-the-lifecycle-of-a-host-registered-to-a-freeipa-realm_satellite",
      'Searching' => "administering_red_hat_satellite/index#Searching_and_Bookmarking_admin",
      'RolesandPermissions' => "administering_red_hat_satellite/index#Managing_Users_and_Roles_admin",
      'LDAPAuthentication' => "configuring_authentication_for_red_hat_satellite_users/index#configuring-an-ldap-server-as-an-external-identity-provider-for-project_authentication",
      'ExternalAuthentication' => "configuring_authentication_for_red_hat_satellite_users/index",
      'Bookmarks' => "administering_red_hat_satellite/index#Searching_and_Bookmarking_admin",

      # Planning
      'SmartProxies' => "overview_concepts_and_deployment_considerations/index#Major-Satellite-Components_planning",
      'Auditing' => "overview_concepts_and_deployment_considerations/index#glossary-of-terms-used-in-satellite_planning",

      # Install
      'HTTP(S)Proxy' => "installing_satellite_server_in_a_connected_network_environment/index#configuring-satellite-server-to-use-an-http-proxy",

      # Misc
      'GettingHelp' => "https://access.redhat.com/products/red-hat-satellite/#support",

      # Managing Security Compliance
      'Monitoring_Compliance_security-compliance' => "managing_security_compliance/index#Monitoring_Compliance_security-compliance",
      'Managing_Compliance_Policies_security-compliance' => "managing_security_compliance/index#Managing_Compliance_Policies_security-compliance",
      'Configuring_SCAP_Contents_security-compliance' => "managing_security_compliance/index#configuring-scap-contents-for-compliance-policies-in-satellite",
      'tailoring-xccdf-profiles_security-compliance' => "managing_security_compliance/index#customizing-xccdf-profiles-with-tailoring-files",
      'deploying-compliance-policies_security-compliance' => "managing_security_compliance/index#deploying-compliance-policies_security-compliance",
    }.freeze

    PLUGINS_DOCUMENTATION = {
      'foreman_azure' => "provisioning_hosts/index#Provisioning_Cloud_Instances_on_Microsoft_Azure_Resource_Manager_azure-provisioning",
      'foreman_discovery' => "provisioning_hosts/index#discovering-hosts-on-a-network",
      'foreman_kubevirt' => "provisioning_hosts/index#Provisioning_Virtual_Machines_Kubevirt_kubevirt-provisioning",
    }.freeze

    DOCS_GUIDES_LINKS = {
      'Managing_Content' => {
        'Products_and_Repositories_content-management' => "managing_content/index#Products_and_Repositories_content-management",
      },
      'Managing_Hosts' => {
        'creating-a-job-template_managing-hosts' => "managing_hosts/index#creating-a-job-template-by-using-web-ui",
        'executing-a-remote-job_managing-hosts' => "managing_hosts/index#Remote-Execution-in-Satellite_managing-hosts",
        'registering-a-host_managing-hosts' => "managing_hosts/index#Registering_Hosts_by_Using_Global_Registration_managing-hosts",
        'setting-minimal-data-collection' => "managing_hosts/index#data-control-settings",
      },
      'Managing_Configurations_Ansible' => {
        'Importing_Ansible_Roles_and_Variables_ansible' => "managing_configurations_by_using_ansible_integration/index#Importing_Ansible_Roles_and_Variables_ansible",
        'Overriding_Ansible_Variables_in_foreman_ansible' => "managing_configurations_by_using_ansible_integration/index#Overriding_Ansible_Variables_in_satellite_ansible",
      },
      'Managing_Configurations_Puppet' => {
        'Configuring_Puppet_Smart_Class_Parameters_managing-configurations-puppet' => "managing_configurations_by_using_puppet_integration/index#Configuring_Puppet_Smart_Class_Parameters_managing-configurations-puppet",
        'Creating_a_Custom_Puppet_Environment_managing-configurations-puppet' => "managing_configurations_by_using_puppet_integration/index#Creating_a_Custom_Puppet_Environment_managing-configurations-puppet",
        'Importing_Puppet_Classes_and_Environments_managing-configurations-puppet' => "managing_configurations_by_using_puppet_integration/index#Importing_Puppet_Classes_and_Environments_managing-configurations-puppet",
        'creating-a-puppet-config-group_managing-configurations-puppet' => "managing_configurations_by_using_puppet_integration/index#creating-a-puppet-config-group_managing-configurations-puppet",
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
