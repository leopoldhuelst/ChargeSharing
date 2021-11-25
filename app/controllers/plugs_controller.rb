class PlugsController < ApplicationController
  def show
  end

  def index
    @plugs = policy_scope(Plug)
    @markers = @plugs.geocoded.map do |plug|
      {
        lat: plug.latitude,
        lng: plug.longitude,
        info_window: render_to_string(partial: "info_window", locals: { plug: plug }),
        image_url: helpers.asset_url('mapmarker.png')
      }
    end
  end

  def new
  end

  def create
    authorize @plug
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
