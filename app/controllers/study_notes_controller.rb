class StudyNotesController < ApplicationController

  before_action :set_study_note, only: [:show, :edit, :update, :destroy]

  def index
    @study_note = StudyNote.all
  end

  def new
    @study_note = StudyNote.new
    @study_note.pericopes.build
  end

  def create
    @study_note = StudyNote.new(study_note_params)

    # puts "\n\n----- StudyNotesController#create"
    # puts "@study_note:       #{@study_note.inspect}"
    # puts "study_note_params: #{study_note_params}"
    # puts "pericope_params:   #{study_note_params[:pericopes_attributes]["0"]}\n\n"

    if @study_note.save
      flash[:notice] = t(:study_note_created)
      redirect_to @study_note
    else
      flash.now[:alert] = t(:study_note_not_created)
      render "new"
    end
  end

  def show
  end

  private

  def study_note_params
    params.require(:study_note).permit(:title, :note, pericopes_attributes: [:id, :name])
  end

  def pericope_params
    params.require(:pericope).permit(:name, :id)
  end

  def set_study_note
    @study_note = StudyNote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:study_note_not_found)
    redirect_to study_note_path
  end
end
