# frozen_string_literal: true

# Controller for Pericopes
# Handling the typical CRUD actions
class PericopesController < ApplicationController
  # Gets data so all Biblebooks and Pericopes can be shown
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Layout/HashAlignment
  def index
    ot = Biblebook.where(testament: 'oud').select('name')
    nt = Biblebook.where(testament: 'nieuw').select('name')

    biblebook_counts = Pericope
                       .group(:biblebook_name)
                       .count
    testament_counts = Pericope
                       .joins(:biblebook)
                       .group('biblebooks.testament')
                       .count
    locals ot:               ot,
           nt:               nt,
           biblebook_counts: biblebook_counts,
           testament_counts: testament_counts
  end

  # rubocop:enable Layout/HashAlignment
  # rubocop:enable Metrics/MethodLength

  # Creates a new Pericope
  def new
    index = params[:index].to_i
    puts "In pericopes_controller, index = #{index}"
    # TODO: Ik zie deze tekst nooit langskomen, dus volgens mij wordt deze
    # code nooit uitgevoerd. Is er wel een pericopecontroller nodig?
    studynote = Studynote.new
    studynote.pericopes.build
    locals studynote: studynote, index: index
  end

  # Gets data to show all Pericopes
  def show
    pericope = Pericope.find(params[:id])
    authorize pericope, :show?
  end

  # Default edit - no code needed
  def edit; end

  # Default destroy - no code needed
  # TODO: is this needed?
  def destroy; end
end
