class PericopesController < ApplicationController
  def index
    @pericope = Pericope.all
    @sequence = []
    @pericope.each do |pericope|
      book = Biblebook.find(pericope.biblebook_id)
      booksequence = book.booksequence
      @sequence << booksequence
    end
  end
end
