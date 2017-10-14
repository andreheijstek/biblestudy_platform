class PericopeString < String

  attr_reader :starting_chapter, :ending_chapter, :starting_verse, :ending_verse
  attr_accessor :biblebook_name

  def initialize(pericope_string)
    super
    @starting_chapter = 0
    @ending_chapter   = 0
    @starting_verse   = 0
    @ending_verse     = 0

    @pericope_to_publish = StringScanner.new self
    parse
  end

  private

  def parse
    @biblebook_name = @pericope_to_publish.scan(/(\d +\p{Word}+)|\p{Word}+/)  # e.g. 1 Samuel or Samuel
    return if @pericope_to_publish.eos?
    @biblebook_name = titleize(@biblebook_name)

    @starting_chapter = @pericope_to_publish.scan(/\s+\d+\s*/).strip.to_i

    if @pericope_to_publish.check(/:/)                                 # is a verse included after the chapter?
      @pericope_to_publish.scan(/:/)                                   # skip the separator
      @starting_verse = @pericope_to_publish.scan(/\s*\d+\s*/).strip.to_i
    end

    if @pericope_to_publish.check(/\s*-/)                              # is there an ending chapter or verse?
      @pericope_to_publish.scan(/\s*-/)                                # skip the separator
      if @pericope_to_publish.check(/\s*\d+:/)                         # is there a chapter AND a verse?
        @ending_chapter = @pericope_to_publish.scan(/\s*\d+/).strip.to_i
        @pericope_to_publish.scan(/:\s*/)                              # skip the separator
        @ending_verse   = @pericope_to_publish.scan(/\d+/).strip.to_i
      else
        @ending_chapter = @starting_chapter
        @ending_verse   = @pericope_to_publish.scan(/\s*\d+/).strip.to_i
      end
    else
      @ending_chapter = @starting_chapter
      @ending_verse   = @starting_verse
    end
  end

  def titleize(str)
    str.split(/ |\_/).map(&:capitalize).join(' ')
  end
end
