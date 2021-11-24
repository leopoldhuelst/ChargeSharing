class PlugsController < ApplicationController
  def show
  end

  def index
    @plugs = Plug.all
    @markers = @plugs.geocoded.map do |plug|
      {
        lat: plug.latitude,
        lng: plug.longitude,
        info_window: render_to_string(partial: "info_window", locals: { plug: plug }),
        image_url: helpers.asset_url('icons8-marker-storm-48.png')
      }
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end