# frozen_string_literal: true

# Controller for Pericopes
# Handling the typical CRUD actions
class PericopesController < ApplicationController
  # Gets data so all Biblebooks and Pericopes can be shown
  # rubocop:disable Metrics/MethodLength
  def index
    ot = Biblebook.where(testament: 'oud').select('name')
    nt = Biblebook.where(testament: 'nieuw').select('name')

    biblebook_counts = Pericope.group(:biblebook_name).count
    puts ('-') * 50
    puts biblebook_counts['Genesis']
    p Pericope.all
    p Studynote.all
    puts ('-') * 50
    testament_counts =
      Pericope.joins(:biblebook).group('biblebooks.testament').count
    locals ot: ot,
           nt: nt,
           biblebook_counts: biblebook_counts,
           testament_counts: testament_counts
  end

  # rubocop:enable Metrics/MethodLength

  def edit; end

  # Default destroy - no code needed
  def destroy; end
end
