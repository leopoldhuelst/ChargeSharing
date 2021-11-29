class PlugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    record.user == user
  end

  def approve?
    true
  end

  def show?
    true
  end
end
