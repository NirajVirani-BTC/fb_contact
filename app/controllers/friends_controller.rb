class FriendsController < ApplicationController

	before_filter :check_authentication

  def index
  	@reviews = Review.find_all_by_facebook_id(params[:id])
  end

  private

  def check_authentication
	redirect_to root_path unless current_user.present?
  end

end
