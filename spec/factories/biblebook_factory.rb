# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id           :integer          not null, primary key
#  abbreviation :string
#  booksequence :integer
#  name         :string
#  testament    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :biblebook do
    name  { 'Voorbeeld bijbelboek' }
    booksequence { 0 }
  end
end
