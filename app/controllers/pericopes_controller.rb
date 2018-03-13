# frozen_string_literal: true

# Controller for Pericopes
# Handling the typical CRUD actions
class PericopesController < ApplicationController
  # skip_after_action :verify_authorized, only: [:new]

  def index
    @ot = Biblebook.where(testament: 'oud').select('name')
    @nt = Biblebook.where(testament: 'nieuw').select('name')

    @biblebook_counts = Pericope.group(:biblebook_name)
                                .count
    @testament_counts = Pericope.joins(:biblebook)
                                .group('biblebooks.testament')
                                .count
  end

  def new
    @index = params[:index].to_i
    puts "In pericopes_controller, index = #{index}"
    @studynote = Studynote.new
    @studynote.pericopes.build
    render layout: false
  end

  def show
    pericope = Pericope.find(params[:id])
    authorize pericope, :show?
  end

  def edit
    puts 'In de edit message'
  end

  def destroy
    puts 'In de destroy message'
  end
end
