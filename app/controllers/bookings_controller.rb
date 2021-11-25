class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    authorize @booking
    @plug = @booking.plug
    @marker = [{
      lat: @plug.latitude,
      lng: @plug.longitude,
      active_image_url: helpers.asset_url('mapmarker.png'),
      inactive_image_url: helpers.asset_url('icons8-marker-storm-50.png'),
      availability: @plug.availability
    }]
  end

  # {:lat=>48.1474286, :lng=>11.560198865721677, :info_window=>"<div class='info-window'>\n  <div class=\"info-window-text\">\n    <p>PLUG TYPE: 2</p>\n    <p>COST: 6</p>\n    <p>DESCRIPTION: Quas consequuntur aut. Asperiores a debitis. Amet voluptas nobis.</p>\n  </div>\n    <p>This Charger is currently unavailable</p>\n</div>\n", :active_image_url=>"http://localhost:3000/assets/mapmarker-ea4c7ae919f5c0e648a5fdfb762cb066d2c00172c3d7f86284828798b411cc93.png", :inactive_image_url=>"http://localhost:3000/assets/icons8-marker-storm-50-fbe0110ab72a28a6ccb19fdf2c9d615221b7f3a1a2ac3a7a1990d76af49bbfac.png", :availability=>1

  def create
    @plug = Plug.find(params[:plug_id])
    @booking = Booking.new(status: 0)
    authorize @booking
    @booking.user = current_user
    @booking.plug = @plug

    if @booking.save
      @plug.availability = 1
      @plug.save
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
