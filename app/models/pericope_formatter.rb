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
      "#{start_verse.chapter}:#{start_verse.verse} - " \
      "#{end_verse.chapter}:#{end_verse.verse}"
  end
end
