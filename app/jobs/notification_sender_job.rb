class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item)
    item.student_ids.each do |student_id|
      Notification.create(item: item, student_id: student_id)
    end
  end
end
