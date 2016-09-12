class PericopesController < ApplicationController
  def index
    @pericope = Pericope.all.order(:name)
    # @study_note = StudyNote.all
  end
end
