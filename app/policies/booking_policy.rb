class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || record.plug.user == user
  end

  def create?
    true
  end

  def stop_booking?
    record.user == user
  end

  def save_payment?
    true
  end

  def approve?
    true
  end
end
