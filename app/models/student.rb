# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  last_name              :string
#  rfc                    :string           default(""), not null
#  grade                  :integer
#  group                  :string
#  bio                    :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  cover_file_name        :string
#  cover_content_type     :string
#  cover_file_size        :integer
#  cover_updated_at       :datetime
#

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :name, :last_name, :rfc, :grade, :group
  validates :rfc, uniqueness: true, length: {is: 10}
  validates :grade, numericality: {only_integer: true, less_than_or_equal_to: 12 }, length: {in: 1..2}
  validates :group, length: {is: 1}
  validate :validate_rfc_regex, :validate_grade_regex, :validate_group_regex

  has_many :posts
  has_many :califications
  has_many :friendships
  has_many :followers, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friends_added, through: :friendships, source: :friend
  has_many :friends_who_added, through: :friendships, source: :student

  has_attached_file :avatar, styles: {thumb: "100x100", medium: "300x300"}, default_url: "/images/avatar/:style/missing_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_attached_file :cover, styles: {thumb: "400x300", medium: "800x600"}, default_url: "/images/cover/:style/missing_cover.jpg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  def friend_ids
    Friendship.active.where(student: self).pluck(:friend_id)
  end

  def friend_ids_notification
    Friendship.pending.where(student: self).pluck(:friend_id).last.to_s.split()
  end

  def student_ids
    Friendship.active.where(friend: self).pluck(:student_id)
  end

  def unviewed_notifications_count
    Notification.for_student(self.id)
  end

  def my_friend?(friend)
    Friendship.friends?(self, friend)
  end

  private
  	def validate_group_regex
  		unless group =~ /\A[a-kA-K]*\z/
      end
  	end

    def validate_rfc_regex
      unless rfc =~ /\A[a-zA-Z]+[0-9]*\z/
      end
    end

    def validate_grade_regex
      unless grade =~ /\A[0-9][0-2]*\z/
      end
    end
end
