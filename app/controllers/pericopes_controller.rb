class PericopesController < ApplicationController
  def index
    @pericope = Pericope.all.order(:biblebook_id)

    # This is a dirty trick. I should sort on biblebook.booksequence
    # And thus do some joining to get the biblebooks, and from there the sequence
  end
end
