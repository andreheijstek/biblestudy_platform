# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  booksequence :integer
#  testament    :string
#  abbreviation :string
#

FactoryBot.define do
  factory :bibleverse_old do
    chapter { 1 }
    verse { 1 }

    initialize_with { new(attributes) }
  end
end
