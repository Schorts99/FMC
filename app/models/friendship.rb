# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  student_id :integer
#  friend_id  :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  include Notificable
  include AASM

  belongs_to :student
  belongs_to :friend, class_name: "Student"

  validates :student_id, uniqueness: {scope: :friend_id, message: "La amistad ya existe"}

  def student_ids
    self.student.friend_ids_notification
  end

  def self.friends?(student, friend)
    return true if student == friend
    Friendship.where(student: student, friend: friend).or(Friendship.where(student: friend, friend: student)).any?
  end

  def self.pending_for_student(student)
    Friendship.pending.where(friend: student)
  end

  def self.accepted_for_student(student)
    Friendship.active.where(friend: student)
  end

  aasm column: "status" do
  	state :pending, initial: true
  	state :active
  	state :block

  	event :accepted do
  		transitions from: [:pending], to: [:active]
  	end

  	event :blocked do
  		transitions from: [:active], to: [:block]
  	end
  end
end
