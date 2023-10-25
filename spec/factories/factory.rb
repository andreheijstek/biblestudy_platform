# frozen_string_literal: true

FactoryBot.define do
  factory :chapter do
    chapter_number { "0" }
    description { "Example description" }
  end

  factory :biblebook do
    name { "bijbelboek" }
    booksequence { 0 }

    factory :biblebook_with_chapters do
      transient { chapters_count { 1 } }

      after(:create) do |biblebook, evaluator|
        create_list(:chapter, evaluator.chapters_count, biblebook: biblebook)
      end
    end
  end

  factory :pericope do
    biblebook
    name { "bijbelboek 1:1-1:1" }
    starting_chapter_nr { 1 }
    starting_verse { 1 } # TODO: ik wil toch weer verse hernoemen naar verse_nr, ivm verwarring verse class
    ending_chapter_nr { 1 }
    ending_verse { 1 }
  end

  factory :studynote do
    title { "titel" }
    note { "text" }

    factory :studynote_with_pericopes do
      transient { pericope_count { 1 } }

      after(:create) do |studynote, evaluator|
        create_list(:pericope, evaluator.pericope_count, studynote: studynote)
      end
    end
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    username { "username" }

    trait :admin do
      admin { true }
    end
  end

  factory :bibleverse, class: BibleVerse do
    chapter_nr { 1 }
    verse_nr { 1 }
  end
end
