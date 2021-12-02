class FavouritesController < ApplicationController
  def add
    @booking = Booking.find(params[:id])
    authorize @booking
    current_user.favorite(@booking.plug)

    redirect_to review_booking_new_path(@booking)
  end
end
