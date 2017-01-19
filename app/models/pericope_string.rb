class PericopeString < String

  attr_reader :starting_chapter, :ending_chapter, :starting_verse, :ending_verse
  attr_accessor :biblebook_name


  def initialize(pericope_string)
    super
    @starting_chapter = 0
    @ending_chapter   = 0
    @starting_verse   = 0
    @ending_verse     = 0

    @studynote_to_publish = StringScanner.new self
    parse
  end

  private

  def parse
    @biblebook_name = @studynote_to_publish.scan(/(\d +\p{Word}+)|\p{Word}+/)  # e.g. 1 Samuel or Samuel
    return if @studynote_to_publish.eos?
    @biblebook_name = titleize(@biblebook_name)

    @starting_chapter = @studynote_to_publish.scan(/\s+\d+\s*/).strip.to_i

    if @studynote_to_publish.check(/:/)                                 # is a verse included after the chapter?
      @studynote_to_publish.scan(/:/)                                   # skip the separator
      @starting_verse = @studynote_to_publish.scan(/\s*\d\s*/).strip.to_i
    end

    if @studynote_to_publish.check(/\s*-/)                              # is there an ending chapter or verse?
      @studynote_to_publish.scan(/\s*-/)                                # skip the separator
      if @studynote_to_publish.check(/\s*\d+:/)                         # is there a chapter AND a verse?
        @ending_chapter = @studynote_to_publish.scan(/\s*\d+/).strip.to_i
        @studynote_to_publish.scan(/:\s*/)                              # skip the separator
        @ending_verse   = @studynote_to_publish.scan(/\d+/).strip.to_i
      else
        @ending_chapter = @starting_chapter
        @ending_verse   = @studynote_to_publish.scan(/\s*\d+/).strip.to_i
      end
    else
      @ending_chapter = @starting_chapter
      @ending_verse   = @starting_verse
    end
  end

  def titleize(str)
    str.split(/ |\_/).map(&:capitalize).join(" ")
  end
end
