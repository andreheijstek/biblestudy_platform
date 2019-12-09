# frozen_string_literal: true

# Turns a String into a PericopeString, containing all constituent elements
# (biblebook, chapter, verse)
# :reek:TooManyInstanceVariables:will be solved later when I really use Verse
# :reek:TooManyMethods:hopefully solved when using Verse
class PericopeString
  attr_reader :starting_chapter, :ending_chapter, :starting_verse,
              :ending_verse, :errors, :pericope_string, :biblebook_name,
              :starting_v, :ending_v

  def initialize(given_pericope)
    @pericope_string = StringScanner.new given_pericope

    @starting_v = Verse.new(0, 0)
    @ending_v   = Verse.new(0, 0)

    @errors = []

    parse

    @starting_chapter = starting_v.chapter
    @ending_chapter   = ending_v.chapter
    @starting_verse   = starting_v.verse
    @ending_verse     = ending_v.verse

    @pericope_string = compose_pericope_string
  end

  private

  # Parses a String, pulling out all constituent elements of a Pericope
  # (biblebook, chapter, verse) and storing these into the object attributes
  def parse
    parse_biblebook
    return if pericope_string.eos?

    parse_chapters_and_verses
  end

  # Parses a string and pulls out chapters and verses
  # Sets all object attributes
  def parse_chapters_and_verses
    parse_starting_chapter
    parse_starting_verse
    parse_ending_chapter_and_verse
  end

  # Parses a string and pulls out the biblebook
  # Sets the @biblebook_name attribute
  # e.g. 1 Samuel or Samuel
  def parse_biblebook
    @biblebook_name = pericope_string.scan(/(\d +\p{Word}+)|\p{Word}+/)
  end

  def parse_starting_chapter
    @starting_v.chapter = parse_digit
  end

  def parse_starting_verse
    return unless contains_verse?
    skip_colon
    @starting_v.verse = parse_digit
  end

  def contains_verse?
    contains_colon?
  end

  def contains_colon?
    @pericope_string.check(/:/)
  end

  def skip_colon
    @pericope_string.scan(/:/)
  end

  def skip_dash
    @pericope_string.scan(/\s*-/)
  end

  def parse_digit
    @pericope_string.scan(/\s*\d+\s*/).strip.to_i
  end

  def has_dash?
    @pericope_string.check(/\s*-/)
  end

  def parse_ending_chapter_and_verse
    if has_ending_chapter_or_verse?
      scan_ending_chapter_and_verse
    else
      @ending_v.chapter = starting_v.chapter
      @ending_v.verse   = starting_v.verse
    end
  end

  def scan_ending_chapter_and_verse
    skip_dash
    if contains_chapter_and_verse?
      @ending_v.chapter = parse_digit
      skip_colon
    else
      @ending_v.chapter = starting_v.chapter
    end
    @ending_v.verse = parse_digit
  end

  def contains_chapter_and_verse?
    @pericope_string.check(/\s*\d+:/)
  end

  def has_ending_chapter_or_verse?
    has_dash?
  end

  # :reek:DuplicateMethodCall:seems a bit overdone here
  # :reek:TooManyStatements: splitting up will make the code less clear
  def compose_pericope_string
    str = biblebook_name.capitalize
    return if whole_book?
    str << ' '
    str << starting_chapter.to_s
    return str if whole_chapter? # TODO: whole_first_chapter?
    str << ':'
    str << starting_verse.to_s
    return str if single_verse?
    str << ' - '
    str << ending_chapter.to_s
    str << ':'
    str << ending_verse.to_s
    str
  end

  def whole_book?
    starting_chapter.zero?
  end

  def whole_chapter?
    starting_verse.zero?
  end

  def single_verse?
    ending_chapter.zero?
  end
end
