# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id             :integer          not null, primary key
#  chapter_number :integer
#  description    :string
#  biblebook_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nrofverses     :integer
#

FactoryBot.define do
  factory :chapter do
    chapter_number { '0' }
    description { 'Example description' }
  end
end
