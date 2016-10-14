class StudynotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true    # because I already do an authenticate_user! in the studynote_controller#before_action
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  private

  def is_owner?
    @user == record.author || @user.try(:admin?)
  end
end
