# frozen_string_literal: true

# Models a verse
class Verse
  include Comparable

  attr_reader :chapter, :verse

  def initialize(chapter, verse)
    @chapter = chapter
    @verse = verse
  end

  def chapter=(chapter)
    @chapter = chapter
  end

  def verse=(verse)
    @verse = verse
  end

  def <=> (other)
    [self.chapter, self.verse] <=> [other.chapter, other.verse]
  end
end
