class FriendsController < ApplicationController

	before_filter :check_authentication

  def index
  	@reviews = Review.find_all_by_facebook_id(params[:id])
  end

  private

  def check_authentication
  	unless user_signed_in?
			render :js => "window.location = '/'"
			flash.now[:error] = "Please SignIn"
    end
  end

end
