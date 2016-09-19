class PericopesController < ApplicationController
  def index
    @pericope = Pericope.includes(:biblebook).order("biblebooks.booksequence")
  end
end
