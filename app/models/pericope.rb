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
#  studynote_id        :integer
#
# Indexes
#
#  index_pericopes_on_biblebook_id  (biblebook_id)
#  index_pericopes_on_studynote_id  (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#

# Models a Pericope, e.g. Gen 1:2-3:4
# Offers a method to reformat an abbreviated Pericope
# into a fully articulated one
# :reek:TooManyInstanceVariables - refactor later
class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :reformat_name

  attr_accessor :biblebook_name, :starting_bibleverse, :ending_bibleverse,
                :starting_chapter_nr, :starting_verse,
                :ending_chapter_nr, :ending_verse

  # Updates the Pericope.name to a nicely formatted name
  def reformat_name
    return unless errors.empty?

    new_name = biblebook_name.dup
    unless whole_book?
      new_name += starting_chapter
      new_name += add_verses unless whole_chapter?
    end
    self.name = new_name
  end

  # Detects if the Pericope is a whole chapter, like Genesis 1
  # @return [Boolean]
  def whole_chapter?
    starting_verse.zero?
  end

  # Detects if the Pericope is a whole book, like Genesis
  # @return [Boolean]
  def whole_book?
    starting_chapter_nr.zero?
  end

  # Detects if a Pericope is a single verse, like Genesis 1:1 - 1:1
  # @return [Boolean]
  def one_verse?
    same_chapter? && same_verse?
  end

  alias single_verse? one_verse?

  def basic_attributes=(tree)
    @biblebook_name      = tree[:biblebook].to_s.strip
    @starting_chapter_nr = tree[:starting_chapter].to_i
    @starting_verse      = tree[:starting_verse].to_i
    @ending_chapter_nr   = tree[:ending_chapter].to_i
    @ending_verse        = tree[:ending_verse].to_i
  end

  def populate_compound_attributes
    @starting_bibleverse = Bibleverse.new({ chapter: starting_chapter_nr,
                                            verse:   starting_verse })
    @ending_bibleverse   = Bibleverse.new({ chapter: ending_chapter_nr,
                                            verse:   ending_verse })
  end

  private

  def same_verse?
    ending_bibleverse == starting_bibleverse
  end

  def same_chapter?
    starting_chapter_nr == ending_chapter_nr
  end

  # Verses are added to a Pericope
  # @return [String]
  def add_verses
    if multiple_chapters?
      full_pericope
    elsif multiple_verses?
      same_chapter
    elsif one_verse?
      one_verse
    end
  end

  # Detects if a Pericope spans multiple verses, like Genesis 1:1 - 1:3
  # @return [Boolean]
  def multiple_verses?
    ending_verse > starting_verse
  end

  # Detects if a Pericope spans multiple chapters, like Genesis 1:1 - 3:1
  # @return [Boolean]
  def multiple_chapters?
    ending_chapter_nr > starting_chapter_nr
  end

  # Formats the starting chapter in the string
  # @return [String]
  def starting_chapter
    " #{starting_chapter_nr}"
  end

  # Formats the full Pericope
  # @return [String]
  def full_pericope
    ":#{starting_verse} - #{ending_chapter_nr}:#{ending_verse}"
  end

  # Formats the string, if the Pericope spans just a single chapter
  # e.g. Genesis 1:1 - 1:2 -> Genesis 1:1 - 2
  def same_chapter
    ":#{starting_verse} - #{ending_verse}"
  end

  # Formats the string if it spans just one verse
  # E.g. Genesis 1:1 - 1:1 -> Genesis 1:1
  def one_verse
    ":#{starting_verse}"
  end
end
