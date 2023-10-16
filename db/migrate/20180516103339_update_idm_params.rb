class UpdateIdmParams < ActiveRecord::Migration[5.1]
  def up
    Parameter.unscoped.where("name like 'idm_%'").each do |param|
      param.name.gsub!('idm_', 'freeipa_')
      param.without_auditing do
        param.save!(:validate => false)
      end
    end
  end

  def down
    Parameter.unscoped.where("name like 'freeipa_%'").each do |param|
      param.name.gsub!('freeipa_', 'idm_')
      param.without_auditing do
        param.save!(:validate => false)
      end
    end
  end
end
