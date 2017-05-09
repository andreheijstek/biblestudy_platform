class PericopesController < ApplicationController

  # skip_after_action :verify_authorized, only: [:new]

  def index
    @ot = Biblebook.where(testament: 'oud').select('name')
    @nt = Biblebook.where(testament: 'nieuw').select('name')

    @biblebook_counts = Pericope.group(:biblebook_name).count
    @testament_counts = Pericope.joins(:biblebook)
                                .group('biblebooks.testament').count
  end

  def new
    @studynote = Studynote.new
    @pericope = @studynote.pericopes.build
    render layout: false
  end

  def show
    pericope = Pericope.find(params[:id])
    authorize pericope, :show?
  end
end
