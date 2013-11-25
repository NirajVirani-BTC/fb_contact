class ReviewsController < ApplicationController
	
	before_filter :authenticate_user!
  before_filter :initialize_review

  def new 
  end

  def create
    review = Review.new(params[:review])
    if review.save
    	flash.now[:notice] = "Review posted"
      redirect_to root_path
    else
      flash.now[:alert] = "please check the details"
      render :new
    end
  end

  private
  def initialize_review
    @review = Review.new
  end
end