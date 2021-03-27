# frozen_string_literal: true

# Formats a Pericope into a well formatted string
# It abbreviates a Pericope as much as possible
# TODO: maybe, later: add formatting options (short, full, whatever)
class PericopeFormatter
  # include ActiveModel::Model
  attr_reader :pericope

  def initialize(pericope)
    @pericope = pericope
  end

  def multiple_whole_chapters?
    (pericope.starting_chapter_nr < pericope.ending_chapter_nr) &&
    (pericope.starting_verse_nr == 0) &&
    (pericope.ending_verse_nr == 0)
  end

  def multiple_full_chapters?
    pericope.starting_verse_nr == 1 &&
    pericope.ending_verse_nr == 1 &&
    pericope.ending_chapter_nr > pericope.starting_chapter_nr
  end

  def full_pericope_starting_with_full_chapter?
    pericope.starting_verse_nr == 1 &&
    pericope.ending_chapter_nr > pericope.starting_chapter_nr
  end

  def format
    name = pericope.biblebook_name.dup
    unless whole_book?
      name += starting_chapter
      if multiple_whole_chapters?
        name += ending_chapter
      elsif multiple_full_chapters?
        name += " - #{pericope.ending_chapter_nr}"
      elsif full_pericope_starting_with_full_chapter?
        name += " - #{pericope.ending_chapter_nr}: #{pericope.ending_verse_nr}"
      else
        name += add_verses unless whole_chapter?
      end
    end
    pericope.name = name
  end

  # Detects if the Pericope is a whole chapter, like Genesis 1
  # @return [Boolean]
  def whole_chapter?
    pericope.starting_verse_nr.zero?
  end

  # Detects if the Pericope is a whole book, like Genesis
  # @return [Boolean]
  def whole_book?
    pericope.starting_chapter_nr.zero?
  end

  # Detects if a Pericope is a single verse, like Genesis 1:1 - 1:1
  # @return [Boolean]
  def one_verse?
    same_chapter? && same_verse?
  end

  alias single_verse? one_verse?

  def same_verse?
    pericope.ending_bibleverse == pericope.starting_bibleverse
  end

  def same_chapter?
    pericope.starting_chapter_nr == pericope.ending_chapter_nr
  end

  def add_verses
    # TODO: ik kan iets doen met duck typing.
    # Full_pericope, SameChapter, etc zijn classes die een add_verses method implementeren
    # add_verses verschuift naar PericopeFormatter, wordt aangeroepen met self als argument
    # zodat het bij de Pericope attributen kan
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
    pericope.ending_verse_nr > pericope.starting_verse_nr
  end

  # Detects if a Pericope spans multiple chapters, like Genesis 1:1 - 3:1
  # @return [Boolean]
  def multiple_chapters?
    pericope.ending_chapter_nr > pericope.starting_chapter_nr
  end

  # Formats the starting chapter in the string
  # @return [String]
  def starting_chapter
    " #{pericope.starting_chapter_nr}"
  end


  def ending_chapter
    " - #{pericope.ending_chapter_nr}"
  end

  # Formats the full Pericope
  # @return [String]
  def full_pericope
    ":#{pericope.starting_verse_nr} - #{pericope.ending_chapter_nr}:#{pericope.ending_verse_nr}"
  end

  # Formats the string, if the Pericope spans just a single chapter
  # e.g. Genesis 1:1 - 1:2 -> Genesis 1:1 - 2
  def same_chapter
    ":#{pericope.starting_verse_nr} - #{pericope.ending_verse_nr}"
  end

  # Formats the string if it spans just one verse
  # E.g. Genesis 1:1 - 1:1 -> Genesis 1:1
  def one_verse
    ":#{pericope.starting_verse_nr}"
  end
end
