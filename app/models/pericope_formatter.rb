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
    "#{pericope.starting_chapter_nr}:#{pericope.starting_verse} - " \
    "#{pericope.ending_chapter_nr}:#{pericope.ending_verse}"
  end
end
