class StudyNotesController < ApplicationController
  def index
  end

  def new
    @study_note = StudyNote.new
  end
end
