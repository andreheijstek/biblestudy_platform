# frozen_string_literal: true

class StudynotesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_studynote, only: %i[show edit update destroy]

  def index
    @studynote = Studynote.all.order(:title)
  end

  def show
    # studynote      = Studynote.find(params[:id])
    # pericope       = studynote.pericopes[0]
    # starting_verse = BibleVerse.create(biblebook:  pericope.biblebook,
    #                                    chapter_nr: pericope.starting_chapter_nr,
    #                                    verse_nr:   pericope.starting_verse)
    # ending_verse   = BibleVerse.create(biblebook:  pericope.biblebook,
    #                                    chapter_nr: pericope.ending_chapter_nr,
    #                                    verse_nr:   pericope.ending_verse)
    # @pericope_range = starting_verse .. ending_verse
  end

  def new
    @index = params[:index].to_i
    @studynote = Studynote.new
    authorize @studynote, :create?
    @studynote.pericopes.build
  end

  def create
    @studynote        = Studynote.new(studynote_params)
    @studynote.author = current_user
    save_studynote
  end

  def edit
    authorize @studynote, :update?
  end

  def update
    authorize @studynote, :update?
    if @studynote.update(studynote_params)
      flash[:notice] = t(:item_updated, item: Studynote.model_name.human)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:item_not_updated, item: Studynote.model_name.human)
      render 'edit'
    end
  end

  def destroy
    authorize @studynote, :destroy?
    @studynote.destroy(studynote_params)
    flash[:notice] = t('activerecord.messages.deleted', model: 'bijbelstudie')
    redirect_to pericopes_path
  end

  private
  def save_studynote
    if @studynote.save
      flash[:notice] = t(:item_created, item: Studynote.model_name.human)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:item_not_created, item: Studynote.model_name.human)
      render 'new'
    end
  end

  def studynote_params
    params.require(:studynote).permit(:id,
                                      :title,
                                      :note,
                                      pericopes_attributes: %i[id name _destroy])
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynotes_path
  end
end
