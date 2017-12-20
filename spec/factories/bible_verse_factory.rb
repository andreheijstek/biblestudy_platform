# frozen_string_literal: true

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
