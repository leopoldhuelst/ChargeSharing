class DashboardsController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @bookings = @user.bookings
    @current = @bookings.last
  end
end
