# frozen_string_literal: true

module AuthorizationHelpers
  def assign_role!(user, role, studynote)
    Role.where(user: user, studynote: studynote).delete_all
    Role.create!(user: user, role: role, studynote: studynote)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
