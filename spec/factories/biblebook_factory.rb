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

FactoryGirl.define do
  factory :biblebook do
    name 'Voorbeeld bijbelboek'
    booksequence 0
  end
end
