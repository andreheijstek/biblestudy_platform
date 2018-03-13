# frozen_string_literal: true

# Policy defining who may CRUD a Studynote
class StudynotePolicy < ApplicationPolicy
  # Policy defining who may CRUD a Studynote
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    @user != nil
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    @user == record.author || @user.try(:admin?)
  end
end
