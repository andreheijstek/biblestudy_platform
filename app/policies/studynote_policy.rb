# frozen_string_literal: true

# Policy class defining who is authorized to CRUD Studynotes
class StudynotePolicy < ApplicationPolicy
  # Policy class defining who is authorized to CRUD Studynotes
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
