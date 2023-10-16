class RemoveSatelliteFromNotificationName < ActiveRecord::Migration[4.2]
  class FakeMailNotification < ActiveRecord::Base
    self.table_name = 'mail_notifications'
  end

  def up
    FakeMailNotification.all.each do |notification|
      if notification_names.keys.include?(notification.name)
        new_name = notification_names[notification.name]
        FakeMailNotification.where(:name => new_name).destroy_all
        notification.name = new_name
        notification.save!
      end
    end
  end

  private

  def notification_names
    {
     :satellite_promote_errata => 'promote_errata',
     :satellote_sync_errata => 'sync_errata',
     :satellite_host_advisory => 'host_errata_advisory'
    }.with_indifferent_access
  end
end
