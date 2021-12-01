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
        active_image_url: helpers.asset_url('bolt4.png'),
        inactive_image_url: helpers.asset_url('bolt3.png'),
        availability: plug.availability
      }
    end
    # raise
  end

  def new
    @plug = Plug.new
    authorize @plug
  end

  def create
    @plug = Plug.new(strong_params)
    @plug.user = current_user
    authorize @plug
    if @plug.save
      if current_user.plugs.count == 1
        redirect_to edit_plug_path(@plug)
      else
        redirect_to dashboard_path
      end
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @plug = Plug.find(params[:id])
    authorize @plug
    render :edit
  end

  def update
    @plug = Plug.find(params[:id])
    authorize @plug
    if @plug.update(strong_params)
      redirect_to edit_plug_path(@plug)
    else
      render :edit
    end
  end

  def destroy
    id = params[:id]
    plug = Plug.find(id)
    plug.destroy
    authorize plug
    if current_user.plugs.count == 1
      redirect_to edit_plug_path(current_user.plugs.last)
    else
      redirect_to dashboard_path
    end
  end

  private

  def strong_params
    params.require(:plug).permit(:location, :description, :fixed_cost_per_15_min, :plug_type, :availability)
  end
end
