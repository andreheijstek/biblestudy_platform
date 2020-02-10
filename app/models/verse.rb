# frozen_string_literal: true

# Models a verse
class Verse
  include Comparable

  #:reek:Attribute - conflicts with Rubocop check
  attr_accessor :chapter, :verse

  # Initialises a new Verse, like 1:2
  # To be used in Ranges, like 1:2 - 3:4
  def initialize(chapter, verse)
    @chapter = chapter
    @verse = verse
  end

  # Spaceship to compare Verses
  def <=>(other)
    [chapter, verse] <=> [other.chapter, other.verse]
  end
end
