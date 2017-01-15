class EstudiantesController < ApplicationController
	before_action :set_student
	before_action :authenticate_student!, only: [:update]
	before_action :authenticate_owner!, only: [:update]

	def show
		@are_friends = current_student.my_friend?(@student)
	end

	def update
		respond_to do |format|
			if @student.update(student_params)
				format.html{ redirect_to @student}
				format.json{ render :show}
				format.js
			else
				format.html{ redirect_to @student, notice: @student.errors.full_messages}
				format.json{ render json: @student.errors}
			end
		end
	end

	private
		def set_student
			@student = Student.find(params[:id])
		end

		def authenticate_owner!
			if current_student != @student
				redirect_to root_path, notice: "No estás autorizado", status: :unauthorized
			end
		end

		def student_params
			params.require(:student).permit(:email, :name, :last_name, :grade, :group, :bio, :avatar, :cover)
		end
end
