class StudyNotesController < ApplicationController

  before_action :set_study_note, only: [:show, :edit, :update, :destroy]

  def index
!   @study_note = StudyNote.all
  end

  def new
    @study_note = StudyNote.new
    @study_note.pericopes.build
  end

  def create
    @study_note = StudyNote.new(study_note_params)
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
    params.require(:study_note).permit(:first_verse, :last_verse, :note)
  end

  def set_study_note
    @study_note = StudyNote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:study_note_not_found)
    redirect_to study_note_path
  end
end
