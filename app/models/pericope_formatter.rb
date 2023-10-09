# frozen_string_literal: true

# Formats a Pericope into a well formatted string
# It does not abbreviate, but shows all attributes in the right order.
# TODO: maybe, later: add formatting options (short, full, whatever)
class PericopeFormatter
  # include ActiveModel::Model
  attr_reader :pericope

  def initialize(pericope)
    @pericope = pericope
  end

  def format
    start_verse = pericope.starting_bibleverse
    end_verse = pericope.ending_bibleverse

    "#{pericope.biblebook_name} " \
      "#{start_verse.chapter_nr}:#{start_verse.verse_nr} - " \
      "#{end_verse.chapter_nr}:#{end_verse.verse_nr}"
  end
end
