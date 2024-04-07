# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  biblebook_name      :string
#  ending_chapter_nr   :integer
#  ending_verse        :integer
#  name                :string
#  sequence            :integer
#  starting_chapter_nr :integer
#  starting_verse      :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  biblebook_id        :integer
#  end_verse_id        :bigint
#  start_verse_id      :bigint
#  studynote_id        :integer
#
# Indexes
#
#  index_pericopes_on_biblebook_id    (biblebook_id)
#  index_pericopes_on_end_verse_id    (end_verse_id)
#  index_pericopes_on_start_verse_id  (start_verse_id)
#  index_pericopes_on_studynote_id    (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#  fk_rails_...  (end_verse_id => bible_verses.id)
#  fk_rails_...  (start_verse_id => bible_verses.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#
class Pericope < ApplicationRecord
  belongs_to :studynote
  belongs_to :biblebook
  belongs_to :start_verse, class_name: "BibleVerse"
  belongs_to :end_verse, class_name: "BibleVerse"

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :to_s

  attr_accessor :starting_bibleverse, :ending_bibleverse

  # def self.parse(raw_pericope)
  #    doorgeven aan de parser
  #    validate_associated(pericope) toevoegen aan studynote
  # end

  # Detects if the Pericope is a whole chapter, like Genesis 1
  # @return [Boolean]
  def whole_chapter?
    starting_bibleverse.verse_nr.zero?
  end

  # Detects if the Pericope is a whole book, like Genesis
  # @return [Boolean]
  def whole_book?
    starting_bibleverse.chapter_nr.zero?
  end

  # Detects if a Pericope is a single verse, like Genesis 1:1 - 1:1
  # @return [Boolean]
  def one_verse?
    same_chapter? && same_verse?
  end

  alias single_verse? one_verse?

  # Detects if a Pericope spans multiple verses, like Genesis 1:1 - 1:3
  # @return [Boolean]
  def multiple_verses?
    ending_bibleverse.verse > starting_bibleverse.verse
  end

  def populate_bibleverses
    @starting_bibleverse =
      BibleVerse.new(
        { chapter_nr: start_verse.chapter_nr, verse_nr: start_verse.verse_nr }
      )
    @ending_bibleverse =
      BibleVerse.new(
        { chapter_nr: end_verse.chapter_nr, verse_nr: end_verse.verse_nr }
      )
  end

  private

  # Updates the Pericope.name to a nicely formatted name
  def to_s
    return unless errors.empty?

    self.name = PericopeFormatter.new(self).format
  end

  def same_verse?
    ending_bibleverse == starting_bibleverse
  end

  def same_chapter?
    starting_bibleverse.chapter_nr == ending_bibleverse.chapter_nr
  end
end
