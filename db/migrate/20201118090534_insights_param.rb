class InsightsParam < ActiveRecord::Migration[6.0]
  def up
    CommonParameter.reset_column_information

    param = CommonParameter.find_or_initialize_by(name: 'host_registration_insights', key_type: 'boolean')
    param.value = true
    param.save
  end
end
