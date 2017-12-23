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
  include Comparable

  has_one :biblebook

  validates_presence_of :biblebook
  validates_presence_of :chapter_nr
  validates_presence_of :verse_nr
  validates :chapter_nr, numericality: { greater_than: 0 }
  validates :verse_nr, numericality: { greater_than: 0 }
  validate :number_of_chapters_in_range
  validate :number_of_verses_in_range

  def number_of_chapters_in_range
    return unless input_safe?
    return if chapter_nr <= nr_of_chapters
    errors.add(:chapter_nr,
               "cannot be greater than the number of chapters in this book,
                 in this case: #{nr_of_chapters}")
  end

  def number_of_verses_in_range
    return unless input_safe? && chapter_nr <= nr_of_chapters
    return if verse_nr <= nr_of_verses
    errors.add(:verse_nr,
               "cannot be greater than the number of verses in this chapter,
                 in this case: #{nr_of_verses}")
  end

  def <=>(other)
    (chapter_nr <=> other.chapter_nr) &&
      (verse_nr <=> other.verse_nr)
  end
  #
  # 1:2 <=> 1:2 = 0
  # 1:2 <=> 1:3 = -1
  # 1:3 <=> 1:2 = +1
  # 1:2 <=> 2:2 = -1
  #
  # Als de hoofdstukken gelijk zijn, dan naar de verzen kijken
  # Als de hoofdstukken gelijk zijn, levert het eerste deel 0 op. Dat is true in ruby, dus dan
  # moet het tweede deel van de expressie geevalueerd worden.


  def next
    if verse_nr == nr_of_verses
      self.class.new(biblebook: biblebook, chapter_nr: chapter_nr + 1, verse_nr: 1)
    else
      self.class.new(biblebook: biblebook, chapter_nr: chapter_nr, verse_nr: verse_nr + 1)
    end
  end
  alias_method :succ, :next

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
