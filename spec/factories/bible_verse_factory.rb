# frozen_string_literal: true
# == Schema Information
#
# Table name: bible_verses
#
#  id           :integer          not null, primary key
#  biblebook_id :integer
#  chapter_nr   :integer
#  verse_nr     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


FactoryBot.define do
  factory :bible_verse, class: BibleVerse do
    trait :jona do
      biblebook do
        Biblebook.find_by(name: 'Genesis') || FactoryBot.create(:biblebook, name: 'Genesis')
      end
    end
    chapter_nr 1
    verse_nr 1
  end
end
