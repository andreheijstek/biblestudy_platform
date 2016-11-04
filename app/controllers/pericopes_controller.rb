class PericopesController < ApplicationController
  def index
    @pericopes = Pericope.all
    @pericope = []
    @pericopes.each do |pericope|
      booksequence = Biblebook.find(pericope.biblebook_id).booksequence
      studynote    = Studynote.find(pericope.studynote_id)
      @pericope << {sequence: booksequence, pericope: pericope.name, author: studynote.author.username,
                    title: studynote.title, note: studynote}
    end
    @pericope.sort_by! { |hsh| hsh[:sequence] }
  end
end
