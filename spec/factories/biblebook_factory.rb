# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id                    :integer          not null, primary key
#  abbreviation          :string
#  booksequence          :integer
#  name                  :string
#  testament             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  bible_verse_id        :bigint
#  biblebook_category_id :bigint
#
# Indexes
#
#  index_biblebooks_on_biblebook_category_id  (biblebook_category_id)
#

FactoryBot.define do
  factory :biblebook do
    name { 'Voorbeeld bijbelboek' }
    booksequence { 0 }

    factory :biblebook_with_chapters do
      transient do
        chapters_count { 5 }
      end

      after(:create) do |biblebook, evaluator|
        create_list(:chapter, evaluator.chapters_count, biblebook:)
      end
    end
  end
end
