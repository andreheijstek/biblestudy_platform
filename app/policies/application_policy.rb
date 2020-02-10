# frozen_string_literal: true

# Overall Policy class defining who is authorized to CRUD items
# (typically overruled in subclasses)
# TODO: check book if comments are correct
class ApplicationPolicy
  attr_reader :user, :record

  # Initializer
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Everybody is allowed to view
  def index?
    true
  end

  # You are allowed to view items if they exist
  def show?
    scope.where(id: record.id).exists?
  end

  # By default you are not allowed to create items
  def create?
    false
  end

  # By default you are not allowed to create items
  def new?
    create?
  end

  # By default you are not allowed to update items
  def update?
    false
  end

  # By default you are not allowed to update items
  def edit?
    update?
  end

  # By default you are not allowed to delete items
  def destroy?
    false
  end

  # No idea
  # TODO: read book to understand again
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # (typically overruled in subclasses)
  # Overall Policy class defining who is authorized to CRUD items
  class Scope
    attr_reader :user, :scope

    # Initializer
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # No idea
    # TODO: check book
    def resolve
      scope
    end
  end
end
