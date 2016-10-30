class PericopesController < ApplicationController
  helper_method :sort_column, 'sort_direction'
  def index
    @pericope = Pericope.all
  end
end
