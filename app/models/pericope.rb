# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  studynote_id        :integer
#  starting_verse      :integer
#  ending_verse        :integer
#  biblebook_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#  ending_chapter_nr   :integer
#  starting_chapter_nr :integer
#  biblebook_name      :string
#  sequence            :integer
#

# Models a Pericope, e.g. Gen 1:2-3:4
# Offers a method to reformat an abbreviated Pericope
# into a fully articulated one
class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :reformat_name

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

  private

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
  # TODO: is dit wel correct? Genesis 1:1 - 2:1 is geen one_verse,
  # maar zou wel True geven
  def one_verse?
    ending_verse == starting_verse
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
