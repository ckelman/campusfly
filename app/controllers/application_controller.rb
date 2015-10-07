class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :small_pic

  def small_pic
  	if user_signed_in? 
      @small_pic = current_user.image
    end
  end
end
