class ReviewsController < ApplicationController
  # def new
  #   @review = Review.new
  #   authorize @review
  # end

  def create
    @booking = Booking.find(params[:id])
    @review = Review.new(strong_params)
    authorize @review
    @review.booking = @booking

    render :back unless @review.save
  end

  def strong_params
    params.require[:review].permit[:rating, :content]
  end
end
