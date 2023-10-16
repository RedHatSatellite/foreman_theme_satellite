class RemoveSatelliteFromNotificationNameSpellCorrection < ActiveRecord::Migration[4.2]
  class FakeMailNotification < ActiveRecord::Base
    self.table_name = 'mail_notifications'

    has_many :user_mail_notifications, :dependent => :destroy, :class_name => 'FakeUserMailNotification', :foreign_key => 'mail_notification_id'
  end

  class FakeUserMailNotification < ActiveRecord::Base
    self.table_name = 'user_mail_notifications'
  end

  def up
    sync_errata_notification = FakeMailNotification.where(name: 'sync_errata').first
    satellite_sync_errata_notification = FakeMailNotification.where(name: 'satellite_sync_errata').first

    if sync_errata_notification && satellite_sync_errata_notification && FakeUserMailNotification.where(:mail_notification_id => sync_errata_notification.id).empty?
      satellite_sync_errata_notification.user_mail_notifications.each do |user_mail_notification|
        FakeUserMailNotification.create(:user_id => user_mail_notification.user_id, :mail_notification_id => sync_errata_notification.id)
      end
    end

    satellite_sync_errata_notification.destroy if satellite_sync_errata_notification.present?
  end
end
