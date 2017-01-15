# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  student_id :integer
#  item_type  :string
#  item_id    :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :student
  belongs_to :item, polymorphic: true

  after_commit {NotificationBroadcastJob.perform_later(self)}
  scope :unviewed, -> {where(viewed: false)}
  scope :latest, -> {order("created_at desc").limit(10)}

  def self.for_student(student_id)
    Notification.where(student_id: student_id).unviewed.count
  end
end
