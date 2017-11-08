# frozen_string_literal: true
# Turns a String into a PericopeString, containing all constituent elements (biblebook, chapter, verse)
class PericopeString

  attr_reader :starting_chapter, :ending_chapter, :starting_verse, :ending_verse, :biblebook_name, :errors

  def initialize(pericope_string)
    @pericope_string  = StringScanner.new pericope_string

    @starting_chapter = 0
    @ending_chapter   = 0
    @starting_verse   = 0
    @ending_verse     = 0

    @errors           = []

    parse
  end

  def biblebook_name=(raw_biblebook_name)
    @biblebook_name = raw_biblebook_name
  end

  private

  # Parses a String, pulling out all constituent elements of a Pericope (biblebook, chapter, verse)
  # and storing these into the object attributes
  def parse
    parse_biblebook
    return if @pericope_string.eos?

    parse_chapters_and_verses
    validate
  end

  # Parses a string and pulls out the biblebook
  # @params [String] @pericope_string - a raw pericope_string, like 'Gen 1:1-5'
  # Sets the @biblebook_name attribute
  # e.g. 1 Samuel or Samuel
  def parse_biblebook
    @biblebook_name = titleize(@pericope_string.scan(/(\d +\p{Word}+)|\p{Word}+/))
  end

  # Parses a string and pulls out chapters and verses
  # @params [String] @pericope_string - a raw pericope_string, like 'Gen 1:1-5'
  # Sets all object attributes
  def parse_chapters_and_verses
    parse_starting_chapter
    parse_starting_verse
    scan_ending_chapter_and_verse
  end

  def parse_starting_chapter
    @starting_chapter = parse_digit
  end

  def parse_starting_verse
    if contains_verse?
      skip_colon
      @starting_verse = parse_digit
    end
  end

  def skip_colon
    @pericope_string.scan(/:/)
  end

  def contains_verse?
    @pericope_string.check(/:/)
  end

  def scan_ending_chapter_and_verse
    if contains_ending_chapter_or_verse?
      skip_dash
      if contains_chapter_and_verse?
        @ending_chapter = parse_digit
        skip_colon
        @ending_verse = parse_digit
      else
        @ending_chapter = starting_chapter
        @ending_verse = parse_digit
      end
    else
      @ending_chapter = starting_chapter
      @ending_verse = starting_verse
    end
  end

  def contains_chapter_and_verse?
    @pericope_string.check(/\s*\d+:/)
  end

  def skip_dash
    @pericope_string.scan(/\s*-/)
  end

  def contains_ending_chapter_or_verse?
    @pericope_string.check(/\s*-/)
  end

  def parse_digit
    @pericope_string.scan(/\s*\d+\s*/).strip.to_i
  end

  # Turns a pericope_string into a good looking and standard format
  #
  # @param (Pericope_String)
  # @return (String)
  #
  def titleize(str)
    str.split(/ |\_/).map(&:capitalize).join(' ')
  end

  def validate
    if starting_chapter > ending_chapter
      @errors << I18n.t('starting_greater_than_ending')
    end
    if starting_chapter == ending_chapter && starting_verse > ending_verse
      @errors << I18n.t('starting_verse_chapter_mismatch')
    end
  end
end
