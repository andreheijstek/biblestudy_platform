class PericopesController < ApplicationController
  def index
    @pericopes = Pericope.all
    @pericope = []
    @pericopes.each do |pericope|
      book = Biblebook.find(pericope.biblebook_id)
      booksequence = book.booksequence
      studynote = Studynote.find(pericope.studynote_id)
      @pericope << {sequence: booksequence, book: pericope.name, author: studynote.author.username, title: studynote.title, note: studynote.note}
    end
    @pericope.sort_by! { |hsh| hsh[:sequence] }
  end
end
