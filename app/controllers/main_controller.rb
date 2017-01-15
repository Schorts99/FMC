class MainController < ApplicationController
  def home
  	@post = Post.new
    @posts = Post.all_for_student(current_student).nuevos.paginate(page: params[:page], per_page: 24)
  end

  def unregistered
  end

  protected
	  def set_layout
	  	return "landing" if action_name == "unregistered"
	  	super
	  end
end