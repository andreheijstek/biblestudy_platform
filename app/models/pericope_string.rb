# Turns a String into a PericopeString, containing all constituent elements (biblebook, chapter, verse)
class PericopeString < String

  attr_reader :starting_chapter, :ending_chapter, :starting_verse, :ending_verse, :biblebook_name

  def initialize(pericope_string)
    super
    @starting_chapter = 0
    @ending_chapter   = 0
    @starting_verse   = 0
    @ending_verse     = 0

    parse
  end

  def biblebook_name=(raw_biblebook_name)
    @biblebook_name = raw_biblebook_name
  end

  private

  # Parses a String, pulling out all constituent elements of a Pericope (biblebook, chapter, verse)
  # and storing these into the object attributes
  def parse
    pericope_to_publish = StringScanner.new self

    parse_biblebook(pericope_to_publish)
    return if pericope_to_publish.eos?

    parse_chapters_and_verses(pericope_to_publish)
  end

  # Parses a string and pulls out chapters and verses
  # @params [String] pericope_to_publish - a raw pericope_string, like 'Gen 1:1-5'
  # Sets all object attributes
  def parse_chapters_and_verses(pericope_to_publish)
    @starting_chapter = pericope_to_publish.scan(/\s+\d+\s*/).strip.to_i

    if pericope_to_publish.check(/:/) # is a verse included after the chapter?
      pericope_to_publish.scan(/:/) # skip the separator
      @starting_verse = pericope_to_publish.scan(/\s*\d+\s*/).strip.to_i
    end

    if pericope_to_publish.check(/\s*-/) # is there an ending chapter or verse?
      pericope_to_publish.scan(/\s*-/) # skip the separator
      if pericope_to_publish.check(/\s*\d+:/) # is there a chapter AND a verse?
        @ending_chapter = pericope_to_publish.scan(/\s*\d+/).strip.to_i
        pericope_to_publish.scan(/:\s*/) # skip the separator
        @ending_verse = pericope_to_publish.scan(/\d+/).strip.to_i
      else
        @ending_chapter = starting_chapter
        @ending_verse = pericope_to_publish.scan(/\s*\d+/).strip.to_i
      end
    else
      @ending_chapter = starting_chapter
      @ending_verse = starting_verse
    end
  end

  # Parses a string and pulls out the official biblebook
  # @params [String] pericope_to_publish - a raw pericope_string, like 'Gen 1:1-5'
  # Sets the @biblebook_name attribute
  def parse_biblebook(pericope_to_publish)
    @biblebook_name = pericope_to_publish.scan(/(\d +\p{Word}+)|\p{Word}+/) # e.g. 1 Samuel or Samuel
    @biblebook_name = titleize(biblebook_name) # Todo: refactor, dit is procedureel, OO zou zijn @biblebook_name.titleize
  end

  # Turns a pericope_string into a good looking and standard format
  #
  # @param (Pericope_String)
  # @return (String)
  #
  def titleize(str)
    str.split(/ |\_/).map(&:capitalize).join(' ')
  end
end
