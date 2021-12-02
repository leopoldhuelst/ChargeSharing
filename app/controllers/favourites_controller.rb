class FavouritesController < ApplicationController
  def add
    @booking = Booking.find(params[:id])
    authorize @booking
    current_user.favorite(@booking.plug)

    redirect_to review_booking_new_path(@booking)
  end

  def index
    @favourites = policy_scope(Favorite)
    @user_favourites = current_user.all_favorites
  end
end
