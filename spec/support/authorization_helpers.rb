# frozen_string_literal: true

# Helpers for authorization tests

#:reek:UtilityFunction - don't know right now how to solve
module AuthorizationHelpers
  def assign_role!(user, role, studynote)
    Role.where(user: user, studynote: studynote).delete_all
    Role.create!(user: user, role: role, studynote: studynote)
  end
end

RSpec.configure { |c| c.include AuthorizationHelpers }
