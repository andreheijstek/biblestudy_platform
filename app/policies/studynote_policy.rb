# frozen_string_literal: true

# Policy class defining who is authorized to CRUD Studynotes
# :reek:InstanceVariableAssumption - should be no problem here. Default Rails
# behaviour, and covered by :set_user before_action
class StudynotePolicy < ApplicationPolicy
  # Policy class defining who is authorized to CRUD Studynotes
  class Scope < Scope
    # No idea
    def resolve
      scope
    end
  end

  # You are allowed to create if you exist as User
  def create?
    @user != nil
  end

  # You are allowed to update if you are the owner of an item
  def update?
    owner?
  end

  # You are allowed to delete if you are the owner of an item
  def destroy?
    owner?
  end

  private

  def owner?
    @user == record.author || @user.try(:admin?)
  end
end
