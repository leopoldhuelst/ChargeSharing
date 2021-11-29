class DashboardsController < ApplicationController
  def index
  end

  def show
    @plug = Plug.last
    authorize @plug
    @user = current_user
  end
end
