# frozen_string_literal: true

# Standard class for authorization and Devise / Pundit
class PericopePolicy < ApplicationPolicy
  # Standard class for authorization and Devise / Pundit
  class Scope < Scope
    def resolve
      scope
    end
  end
end
