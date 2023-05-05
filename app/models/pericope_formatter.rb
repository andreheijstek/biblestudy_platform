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
    "#{pericope.biblebook_name} " \
    "#{pericope.starting_bibleverse.chapter}:#{pericope.starting_bibleverse.verse} - " \
    "#{pericope.ending_bibleverse.chapter}:#{pericope.ending_bibleverse.verse}"
  end
end
