module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :item
    after_commit :send_notification_to_students
  end

  def send_notification_to_students
    if self.respond_to? :student_ids
      NotificationSenderJob.perform_later(self)
    end
  end
end
