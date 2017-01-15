class FriendshipsController < ApplicationController
	before_action :find_friend, except: [:index, :update, :destroy]
	before_action :find_friendship, only: [:update, :destroy]

	def index
		@pending_friendships = current_student.followers.pending.decorate
		@accepted_friendships = current_student.followers.active.decorate
		@pending_requests = current_student.friendships.pending.decorate
		@accepted_requests = current_student.friendships.active.decorate
		@blocked_friendships = current_student.followers.block.decorate
	end

	def create
		@friendship = Friendship.new(student: current_student, friend: @friend)
		respond_to do |format|
			if @friendship.save
				format.html {redirect_to @friend}
				format.js
			else
				format.html {redirect_to @friend, notice: "Error con la solicitud de amistad"}
				format.js
			end
		end
	end

	def update
		if params[:status] == "1"
			@friendship.accepted!
		elsif params[:status] == "0"
			@friendship.blocked!
		end
		respond_to do |format|
			format.html {redirect_to friendships_path}
		end
	end

	def destroy
		@friendship.destroy
		respond_to do |format|
			format.html{redirect_to friendships_path}
		end
	end

	private
		def find_friend
			@friend = Student.find(params[:friend_id])
		end

		def find_friendship
			@friendship = Friendship.find(params[:id])
		end
end
