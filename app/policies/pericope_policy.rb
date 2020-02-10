# frozen_string_literal: true

# Policy class defining who is authorized to CRUD Pericopes
class PericopePolicy < ApplicationPolicy
  # Policy class defining who is authorized to CRUD Pericopes
  class Scope < Scope
    # No idea
    # TODO: read book
    def resolve
      scope
    end
  end
end
