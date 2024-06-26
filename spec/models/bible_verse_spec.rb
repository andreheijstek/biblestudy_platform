# frozen_string_literal: true

# == Schema Information
#
# Table name: bible_verses
#
#  id         :bigint           not null, primary key
#  chapter_nr :integer
#  verse_nr   :integer
#  build_stubbedd_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe BibleVerse, type: :model do
  it "recognises BibleVerses with equal chapters and verses to be equal" do
    verse1 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 2)
    verse2 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 2)

    expect(verse1 == verse2).to be_truthy
  end

  it "recognises BibleVerses with different chapters and equal verses to be different" do
    verse1 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 2)
    verse2 = build_stubbed(:bibleverse, chapter_nr: 2, verse_nr: 2)

    expect(verse1 == verse2).to be_falsey
  end

  it "recognises BibleVerses with equal chapters and different verses to be different" do
    verse1 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 1)
    verse2 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 2)

    expect(verse1 == verse2).to be_falsey
  end

  it "compares BibleVerses large and small" do
    verse1 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 2)
    verse2 = build_stubbed(:bibleverse, chapter_nr: 1, verse_nr: 3)

    expect(verse1 < verse2).to be_truthy
  end
end
