class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @booking = Booking.find(params[:id])
    @review.booking = @booking
    authorize @review
  end

  def create
    @booking = Booking.find(params[:id])
    @review = Review.new(strong_params)
    @review.booking = @booking
    @review.review_type = 1
    authorize @review
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  def strong_params
    params.require(:review).permit(:rating, :contents)
  end
end
