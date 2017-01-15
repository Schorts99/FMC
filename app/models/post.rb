# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :student
  scope :nuevos, -> {order("created_at desc")}
  after_create :send_to_action_cable

  def self.all_for_student(student)
  	Post.where(student_id: student.id).or(Post.where(student_id: student.friend_ids)).or(Post.where(student_id: student.student_ids))
  end

  private
    def send_to_action_cable
      data = {message: to_html, action:"new_post"}
      self.student.friend_ids.each do |friend_id|
        ActionCable.server.broadcast "posts_#{friend_id}", data
      end
      self.student.student_ids.each do |friend_id|
        ActionCable.server.broadcast "posts_#{friend_id}", data
      end
    end

    def to_html
      ApplicationController.renderer.render(partial: "posts/post", locals: {post: self})
    end
end
