# frozen_string_literal: true

# Controller for Pericopes
# Handling the typical CRUD actions
class PericopesController < ApplicationController
  # skip_after_action :verify_authorized, only: [:new]

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

  def new
    index = params[:index].to_i
    puts "In pericopes_controller, index = #{index}"
    studynote = Studynote.new
    studynote.pericopes.build
    locals studynote: studynote, index: index
  end

  def show
    pericope = Pericope.find(params[:id])
    authorize pericope, :show?
  end

  def edit; end

  def destroy; end
end
