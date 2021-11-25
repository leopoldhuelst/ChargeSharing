class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @plug = Plug.find(params[:plug_id])
    @booking = Booking.new(status: 0)
    authorize @booking
    @booking.user = current_user
    @booking.plug = @plug

    if @booking.save
      redirect_to plug_booking_path(@plug, @booking)
    else
      render :new
    end
  end

  def approve
    @plug = Plug.find(params[:id])
    authorize @plug
  end
end
