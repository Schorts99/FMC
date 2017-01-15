class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification_count = Notification.for_student(notification.student_id)
    ActionCable.server.broadcast "notifications.#{notification.student_id}", {action: "new_notification", message: notification_count}
  end
end
