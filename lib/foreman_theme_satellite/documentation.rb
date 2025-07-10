# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module ForemanThemeSatellite
  module Documentation
    USER_GUIDE_DICTIONARY = {
      # Managing Hosts
      'ForemanRemoteExecution' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#configuring-and-setting-up-remote-jobs",
      'ExecutingaJob' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#configuring-the-global-capsule-remote-execution-setting-by-using-web-ui",
      'JobTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#customizing-job-templates",
      'ReportTemplates' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#Using_Report_Templates_to_Monitor_Hosts_managing-hosts",
      'Reports' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#Using_Report_Templates_to_Monitor_Hosts_managing-hosts",

      # Provisioning Hosts
      'Architectures' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#creating-architectures-by-using-web-ui",
      'Provisioning' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index",
      'InstallationMedia' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#adding-installation-media-by-using-web-ui",
      'PartitionTables' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#creating-partition-tables-by-using-web-ui",
      'ProvisioningTemplates' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#provisioning-templates",
      'OperatingSystems' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#creating-operating-systems-by-using-web-ui",
      'UsingComputeProfiles' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#creating-compute-profiles-by-using-web-ui",
      'ComputeResources' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index",
      'NoVNC' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#using-novnc-to-access-virtual-machines_provisioning",
      'VMwareNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Virtual_Machines_in_VMware_vmware-provisioning",
      'OpenStackNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Cloud_Instances_OpenStack_openstack-provisioning",
      'LibvirtNote' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Virtual_Machines_on_KVM_kvm-provisioning",
      'EC2' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#provisioning-cloud-instances-on-amazon-ec2",
      'GoogleComputeEngineNotes' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Cloud_Instances_on_Google_Compute_Engine_gce-provisioning",
      'Networking' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#adding-a-subnet-to-server-by-using-web-ui",

      # Puppet Guide
      'FactsandtheENC' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#performing-configuration-management_managing-configurations-puppet",
      'using-config-groups' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#creating-a-puppet-config-group_managing-configurations-puppet",
      'SmartMatchers' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#Configuring_Puppet_Smart_Class_Parameters_managing-configurations-puppet",
      'Parameters' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#Configuring_Puppet_Smart_Class_Parameters_managing-configurations-puppet",
      'Classes' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#Importing_Puppet_Classes_and_Environments_managing-configurations-puppet",
      'Environments' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_puppet_integration/index#Creating_a_Custom_Puppet_Environment_managing-configurations-puppet",

      # Administering
      'ConfigurationOptions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index",
      'PuppetReports' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index#Using_the_Project_Content_Dashboard_admin",
      'Mail_Notifications' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index#Configuring_Email_Notifications_admin",
      'Realm' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/index#configuring-project-to-manage-the-lifecycle-of-a-host-registered-to-a-freeipa-realm_satellite",
      'Searching' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index#Searching_and_Bookmarking_admin",
      'RolesandPermissions' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index#Managing_Users_and_Roles_admin",
      'LDAPAuthentication' => "#{ForemanThemeSatellite.documentation_root}/configuring_authentication_for_red_hat_satellite_users/index#configuring-an-ldap-server-as-an-external-identity-provider-for-project_authentication",
      'ExternalAuthentication' => "#{ForemanThemeSatellite.documentation_root}/configuring_authentication_for_red_hat_satellite_users/index",
      'Bookmarks' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/index#Searching_and_Bookmarking_admin",
      'Policydeploymentoptions' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#compliance-policy-deployment-options_security-compliance",
      'CreatingSCAPcontent' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#Configuring_SCAP_Contents_security-compliance",

      # Planning
      'SmartProxies' => "#{ForemanThemeSatellite.documentation_root}/overview_concepts_and_deployment_considerations/index#Major-Satellite-Components_planning",
      'Auditing' => "#{ForemanThemeSatellite.documentation_root}/overview_concepts_and_deployment_considerations/index#glossary-of-terms-used-in-satellite_planning",

      # Install
      'HTTP(S)Proxy' => "#{ForemanThemeSatellite.documentation_root}/installing_satellite_server_in_a_connected_network_environment/index#Configuring_Server_with_an_HTTP_Proxy_satellite",

      # Misc
      'GettingHelp' => "https://access.redhat.com/products/red-hat-satellite/#support",

      # Managing Security Compliance
      'Monitoring_Compliance_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#Monitoring_Compliance_security-compliance",
      'Managing_Compliance_Policies_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#Managing_Compliance_Policies_security-compliance",
      'Configuring_SCAP_Contents_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#Configuring_SCAP_Contents_security-compliance",
      'tailoring-xccdf-profiles_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#tailoring-xccdf-profiles_security-compliance",
      'deploying-compliance-policies_security-compliance' => "#{ForemanThemeSatellite.documentation_root}/managing_security_compliance/index#deploying-compliance-policies_security-compliance",
    }.freeze

    PLUGINS_DOCUMENTATION = {
      'foreman_azure' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Cloud_Instances_on_Microsoft_Azure_Resource_Manager_azure-provisioning",
      'foreman_discovery' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#discovering-hosts-on-a-network",
      'foreman_kubevirt' => "#{ForemanThemeSatellite.documentation_root}/provisioning_hosts/index#Provisioning_Virtual_Machines_Kubevirt_kubevirt-provisioning",
    }.freeze

    DOCS_GUIDES_LINKS = {
      'Managing_Content' => {
        'Products_and_Repositories_content-management' => "#{ForemanThemeSatellite.documentation_root}/managing_content/index#Products_and_Repositories_content-management",
      },
      'Managing_Hosts' => {
        'creating-a-job-template_managing-hosts' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#creating-a-job-template-by-using-web-ui",
        'executing-a-remote-job_managing-hosts' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#Remote-Execution-in-Satellite_managing-hosts",
        'registering-a-host_managing-hosts' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#Registering_Hosts_by_Using_Global_Registration_managing-hosts",
        'setting-minimal-data-collection' => "#{ForemanThemeSatellite.documentation_root}/managing_hosts/index#data-control-settings",
      },
      'Managing_Configurations_Ansible' => {
        'Importing_Ansible_Roles_and_Variables_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_ansible_integration/index#Importing_Ansible_Roles_and_Variables_ansible",
        'Overriding_Ansible_Variables_in_foreman_ansible' => "#{ForemanThemeSatellite.documentation_root}/managing_configurations_by_using_ansible_integration/index#Overriding_Ansible_Variables_in_satellite_ansible",
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
