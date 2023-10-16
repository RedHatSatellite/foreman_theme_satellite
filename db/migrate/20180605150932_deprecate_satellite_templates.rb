require_relative '../../lib/foreman_theme_satellite/deprecated_templates'

class DeprecateSatelliteTemplates < ActiveRecord::Migration[5.1]
  def up
    ForemanThemeSatellite::DEPRECATED_TEMPLATES.each do |old_name, new_name|
      old_template = ProvisioningTemplate.unscoped.find_by(name: old_name)
      new_template = ProvisioningTemplate.unscoped.find_by(name: new_name)

      next unless old_template
      old_template.name = 'DEPRECATED ' + old_name

      if new_template
        copy_os_default_associations(old_template, new_template)
        copy_template_combinations(old_template, new_template)
        copy_operatingsystems(old_template, new_template)
        new_template.without_auditing do
          new_template.save!
        end
      else
        # prepare for seeding the template
        remove_old_audits(new_name)
      end

      old_template.save!
    end
  end

  def remove_old_audits(destination)
    Audit.where(:auditable_type => 'ProvisioningTemplate', :auditable_name => destination).delete_all
  end

  def copy_os_default_associations(source, destination)
    source.os_default_templates.update_all(provisioning_template_id: destination.id)
    destination.reload
  end

  def copy_template_combinations(source, destination)
    dest_associations = destination.template_combinations.all
    source.template_combinations.each do |old|
      next if dest_associations.select { |assoc| assoc.environment_id = old.environment_id && assoc.hostgroup_id == old.hostgroup_id }.any?

      destination.template_combinations.build(
        environment_id: old.environment_id,
        hostgroup_id: old.hostgroup_id
      )
    end
  end

  def copy_operatingsystems(source, destination)
    destination.operatingsystem_ids = (destination.operatingsystem_ids + source.operatingsystem_ids).uniq
  end
end
