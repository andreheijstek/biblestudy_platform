# frozen_string_literal: true

# Helpers for factories that can't be made directly with FactoryBot
# include FactoryHelpers if you need this
module FactoryHelpers
  module_function
  def studynote_with_pericopes(pericope_count: 1)
    FactoryBot.create(:studynote) do |studynote|
      FactoryBot.create_list(:pericope, pericope_count, studynote: studynote)
    end
  end
end
