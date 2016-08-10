class VersesController < ApplicationController

  before_action :set_chapter
  before_action :set_verse, only: [:show, :edit, :update, :destroy]

  def new
    @verse = @chapter.verses.build
  end

  def create
    @verse = @chapter.verses.build(verse_params)
    if @verse.save
      flash[:notice] = t(:verse_created)
      redirect_to [@biblebook, @chapter, @verse]
    else
      flash.now[:alert] = t(:verse_not_created)
      render "new"
    end
  end

  def show
  end

  private

  def verse_params
    params.require(:verse).permit(:verse_number, :verse_text)
  end

  def set_chapter
    @biblebook = Biblebook.find(params[:biblebook_id])
    @chapter = Chapter.find(params[:chapter_id])
  end

  def set_verse
    @verse = @chapter.verses.find(params[:id])
  end

end
