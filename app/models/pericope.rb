# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id             :integer          not null, primary key
#  biblebook_name :string
#  name           :string
#  sequence       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  biblebook_id   :integer
#  end_verse_id   :bigint
#  start_verse_id :bigint
#  studynote_id   :integer
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
  belongs_to :start_verse, class_name: 'BibleVerse'
  belongs_to :end_verse, class_name: 'BibleVerse'

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :reformat_name

  attr_accessor :starting_bibleverse, :ending_bibleverse

  # Detects if the Pericope is a whole chapter, like Genesis 1
  # @return [Boolean]
  def whole_chapter?
    starting_bibleverse.verse.zero?
  end

  # Detects if the Pericope is a whole book, like Genesis
  # @return [Boolean]
  def whole_book?
    starting_bibleverse.chapter.zero?
  end

  # Detects if a Pericope is a single verse, like Genesis 1:1 - 1:1
  # @return [Boolean]
  def one_verse?
    same_chapter? && same_verse?
  end

  alias_method :single_verse?, :one_verse?

  # Detects if a Pericope spans multiple verses, like Genesis 1:1 - 1:3
  # @return [Boolean]
  def multiple_verses?
    ending_bibleverse.verse > starting_bibleverse.verse
  end

  def populate_bibleverses
    @starting_bibleverse =
      BibleverseOld.new({ chapter: starting_chapter_nr, verse: starting_verse})
    @ending_bibleverse =
      BibleverseOld.new({ chapter: ending_chapter_nr, verse: ending_verse})
  end

  private

  # Updates the Pericope.name to a nicely formatted name
  # TODO: why not #to_s?
  def reformat_name
    return unless errors.empty?

    self.name = PericopeFormatter.new(self).format
  end

  def same_verse?
    ending_bibleverse == starting_bibleverse
  end

  def same_chapter?
    starting_bibleverse.chapter == ending_bibleverse.chapter
  end
end
