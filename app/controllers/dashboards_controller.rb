class DashboardsController < ApplicationController
  def index
  end

  def show
    @bookings = policy_scope(current_user.bookings)
    @user = current_user
    @current = @bookings.last
    authorize @current
  end
end
