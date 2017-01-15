module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_student

    def connect
      self.current_student = find_student
    end

    def find_student
      student_id = cookies.signed["student.id"]
      current_student = Student.find_by(id: student_id)
      if current_student
        current_student
      else
        reject_unauthorized_connection
      end
    end
  end
end
