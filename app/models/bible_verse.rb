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

class BibleVerse < ApplicationRecord
  belongs_to :biblebook

  validates_presence_of :biblebook
  validates_presence_of :chapter_nr
  validates_presence_of :verse_nr
  validates :chapter_nr, numericality: { greater_than: 0 }
  validates :verse_nr, numericality: { greater_than: 0 }
  validate :number_of_chapters_in_range
  validate :number_of_verses_in_range

  def number_of_chapters_in_range
    if input_safe?
      if chapter_nr > biblebook.nr_of_chapters
        errors.add(:chapter_nr,
                   "cannot be greater than the number of chapters in this book,
                   in this case: #{biblebook.nr_of_chapters}")
      end
    end
  end

  def number_of_verses_in_range
    if input_safe? && chapter_nr <= biblebook.nr_of_chapters
      chapter = biblebook.chapters.where(chapter_number: chapter_nr).first
      n = chapter.nrofverses
      if verse_nr > chapter.nrofverses
        errors.add(:verse_nr,
                   "cannot be greater than the number of verses in this chapter,
                   in this case: #{biblebook.chapters[chapter_nr].nrofverses}")
      end
    end
  end

  private
  def input_safe?
    !biblebook.nil? && !chapter_nr.nil? && chapter_nr.positive? && !verse_nr.nil? && verse_nr.positive?
  end
end
