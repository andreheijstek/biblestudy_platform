# frozen_string_literal: true

# # == Schema Information
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

# Models one bibleverse, e.g. [book: Genesis, chapter: 1, verse: 2]
# To be used as basis for Pericope that is really a Range of Verses
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
    return unless input_safe?
    if chapter_nr > nr_of_chapters
      errors.add(:chapter_nr,
                 "cannot be greater than the number of chapters in this book,
                   in this case: #{nr_of_chapters}")
    end
  end

  def number_of_verses_in_range
    return unless input_safe? && chapter_nr <= nr_of_chapters
    if verse_nr > nr_of_verses
      errors.add(:verse_nr,
                 "cannot be greater than the number of verses in this chapter,
                   in this case: #{nr_of_verses}")
    end
  end

  private

  # TODO: This is really ugly, but apparently you can't control the order of
  # Rails validators.
  # So my custom validator do have to check what the standard validators for
  # presence do as well.
  def input_safe?
    !biblebook.nil? && !chapter_nr.nil? && chapter_nr.positive? &&
      !verse_nr.nil? && verse_nr.positive?
  end

  def nr_of_chapters
    biblebook.nr_of_chapters
  end

  def nr_of_verses
    biblebook.chapters.where(chapter_number: chapter_nr).first.nrofverses
  end
end
