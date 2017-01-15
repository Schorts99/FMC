class AddAttachmentCoverAndAvatarToStudents < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :students, :avatar
  	add_attachment :students, :cover
  end
end