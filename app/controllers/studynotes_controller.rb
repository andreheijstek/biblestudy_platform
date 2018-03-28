# frozen_string_literal: true

# Controller for Studynotes (the main object in the application)
# Handling the typical CRUD actions
class StudynotesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_studynote, only: %i[show edit update destroy]

  attr_reader :studynote

  def index
    studynote = Studynote.all.order(:title)
    locals studynote: studynote
  end

  def show
    locals studynote: studynote
  end

  def new
    index     = params[:index].to_i
    studynote = Studynote.new
    authorize studynote, :create?
    studynote.pericopes.build
    locals studynote: studynote, index: index
  end

  def create
    studynote        = Studynote.new(studynote_params)
    studynote.author = current_user
    save_studynote(studynote)
  end

  def edit
    authorize studynote, :update?
    locals studynote: studynote
  end

  def update
    authorize studynote, :update?
    update_studynote
  end

  def destroy
    authorize studynote, :destroy?
    studynote.destroy
    flash[:notice] = t('activerecord.messages.deleted', model: 'bijbelstudie')
    redirect_to pericopes_path
  end

  private

  def update_studynote
    name = Studynote.model_name.human
    if studynote.update(studynote_params)
      flash[:notice] = t(:item_updated, item: name)
      redirect_to studynote
    else
      flash.now[:alert] = t(:item_not_updated, item: name)
      locals :edit, studynote: studynote
    end
  end

  def save_studynote(studynote)
    name = Studynote.model_name.human
    if studynote.save
      flash[:notice] = t(:item_created, item: name)
      redirect_to studynote
    else
      flash.now[:alert] = t(:item_not_created, item: name)
      locals :edit, studynote: studynote
    end
  end

  def studynote_params
    params.require(:studynote).permit(:id,
                                      :title,
                                      :note,
                                      pericopes_attributes:
                                      %i[id name _destroy])
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynotes_path
  end
end
