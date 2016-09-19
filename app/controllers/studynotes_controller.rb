class StudynotesController < ApplicationController

  before_action :set_studynote, only: [:show, :edit, :update, :destroy]

  def index
    @studynote = Studynote.all.order(:title)
  end

  def new
    @studynote = Studynote.new
    @studynote.pericopes.build
  end

  def create
    @studynote = Studynote.new(studynote_params)

    if @studynote.save
      flash[:notice] = t(:studynote_created)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:studynote_not_created)
      render "new"
    end
  end

  def show
  end

  private

  def studynote_params
    params.require(:studynote).permit(:title, :note, pericopes_attributes: [:id, :name])
  end

  def pericope_params
    params.require(:pericopes).permit(:name, :id)
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynote_path
  end
end
