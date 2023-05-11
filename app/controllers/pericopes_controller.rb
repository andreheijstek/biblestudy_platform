# frozen_string_literal: true

# Controller for Pericopes
# Handling the typical CRUD actions
class PericopesController < ApplicationController
  # Gets data so all Biblebooks and Pericopes can be shown
  def index
    ot = Biblebook.where(testament: 'oud').select('name')
    nt = Biblebook.where(testament: 'nieuw').select('name')

    biblebook_counts = Pericope.group(:biblebook_name).count
    testament_counts =
      Pericope.joins(:biblebook).group('biblebooks.testament').count
    locals ot:,
           nt:,
           biblebook_counts:,
           testament_counts:
  end

  def edit; end

  # Default destroy - no code needed
  def destroy; end
end
