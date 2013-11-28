class ReviewsController < ApplicationController
	
	before_filter :check_authentication, :initialize_review

  def new 
  end

  def create
    params[:review][:rating] = params[:score]
    params[:review][:facebook_id] = session[:facebook_id]
    review = Review.new(params[:review])

    if review.save
      redirect_to home_index_path
      flash[:notice] = "Review posted successfully"
    else
      flash.now[:alert] = "Please specify all the details"
      render :new
    end
  end

  private

  def check_authentication
    unless user_signed_in?
      redirect_to root_path
      flash[:error] = "Please SignIn"
    end
  end

  def initialize_review
    @review = Review.new
  end
end