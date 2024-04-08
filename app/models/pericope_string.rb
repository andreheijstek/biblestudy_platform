# frozen_string_literal: true

# PORO class to handle pericopes
# To keep this class at a single responsibility, this class only takes
# care of basic handling of the pericope. It parses it into the constituent
# parts, but does not handle further logic to complete abbreviated
# biblebook names, or to check on valid chapters and verses
class PericopeString
  include PericopeValidatorUtilities

  def initialize(pericope)
    @pericope = pericope
    @tree = PericopeParser.new.parse(pericope)
  end

  def to_s
    @pericope.to_s
  end

  def biblebook
    get_biblebook_from_tree(@tree)
  end

  def first_chapter
    @tree[:starting_chapter].to_i
  end

  def first_verse
    @tree[:starting_verse].to_i
  end

  def last_chapter
    @tree[:ending_chapter].to_i
  end

  def last_verse
    @tree[:ending_verse].to_i
  end
end
