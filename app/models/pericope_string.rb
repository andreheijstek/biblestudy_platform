class PericopeString < String

  attr_reader :biblebook_name, :starting_chapter, :ending_chapter, :starting_verse, :ending_verse

  def initialize(pericope_string)
    super

    @starting_chapter = 0
    @ending_chapter   = 0
    @starting_verse   = 0
    @ending_verse     = 0

    @pericope = StringScanner.new self
    parse
  end

  private

  def parse
    @biblebook_name = @pericope.scan(/(\d +\p{Word}+)|\w{2,50}/ )  # e.g. 1 Samuel or Samuel
    return if @pericope.eos?

    @starting_chapter = @pericope.scan(/\s+\d+\s*/ ).strip.to_i

    if @pericope.check(/:/ )                                 # is a verse included after the chapter?
      @pericope.scan(/:/ )                                   # skip the separator
      @starting_verse = @pericope.scan(/\s*\d\s*/ ).strip.to_i
    end

    if @pericope.check(/\s*-/ )                              # is there an ending chapter or verse?
      @pericope.scan(/\s*-/ )                                # skip the separator
      if @pericope.check(/\s*\d+:/ )                         # is there a chapter AND a verse?
        @ending_chapter = @pericope.scan(/\s*\d+/ ).strip.to_i
        @pericope.scan(/:\s*/ )                              # skip the separator
        @ending_verse   = @pericope.scan(/\d+/ ).strip.to_i
      else
        @ending_chapter = @starting_chapter
        @ending_verse   = @pericope.scan(/\s*\d+/ ).strip.to_i
      end
    else
      @ending_chapter = @starting_chapter
      @ending_verse   = @starting_verse
    end
  end
end
