# frozen_string_literal: true

class PericopePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
