class PlugsController < ApplicationController
  def show
    @plugs = policy_scope(Plug)
  end

  def index
    @plugs = policy_scope(Plug)
    @markers = @plugs.geocoded.map do |plug|
      {
        lat: plug.latitude,
        lng: plug.longitude,
        info_window: render_to_string(partial: "info_window", locals: { plug: plug }),
        active_image_url: helpers.asset_url('mapmarker.png'),
        inactive_image_url: helpers.asset_url('mapmarkerunavailable.png'),
        availability: plug.availability
      }
    end
    # raise
  end

  def new
  end

  def create
    authorize @plug
  end

  def edit
    @user = current_user
    authorize @plug = Plug.find(params[:id])
  end

  def update
    if @plug.update(strong_params)
      redirect_to plug_path(@plug.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def strong_params
    params.require(:plug).permit(:location, :description, :fixed_cost_per_15_min, :plug_type)
  end
end
