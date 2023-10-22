# frozen_string_literal: true

# Controller for Studynotes (the main object in the application)
# Handling the typical CRUD actions
class StudynotesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_studynote, only: %i[show edit update destroy]

  attr_reader :studynote

  # Gets all Studynotes to be shown
  def index
    studynote = Studynote.all.order(:title)
    locals studynote:
  end

  # Gets data to show one Studynote
  def show
    locals studynote:
  end

  # Creates a new Studynote
  def new
    studynote = Studynote.new
    authorize studynote, :create?
    studynote.pericopes.build
    locals studynote:, index: 0
  end

  # Creates and saves a new Studynote
  def create
    @studynote = Studynote.new(studynote_params)
    @tag_list = params[:studynote][:tag_list].split(",") # Assuming tags are comma-separated
    # TODO: making tag_list an instance variable is a quick trick. I think passing a variable is better,
    # but that breaks existing callers of save_studynote
    studynote.author = current_user
    save_studynote
  end

  # Edits an existing Studynote
  def edit
    authorize studynote, :update?
    locals studynote:
  end

  # Updates an existing Studynote
  def update
    authorize studynote, :update?
    @tag_list = params[:studynote][:tag_list].split(",") # Assuming tags are comma-separated
    update_studynote
  end

  # Delets an existing Studynote
  def destroy
    authorize studynote, :destroy?
    studynote.destroy
    flash[:notice] = t("activerecord.messages.deleted", model: "bijbelstudie")
    redirect_to pericopes_path
  end

  private

  # :reek:TooManyStatements
  def update_studynote
    name = Studynote.model_name.human
    if studynote.update(studynote_params)
      @studynote.tag_list = @tag_list
      flash[:notice] = t(:item_updated, item: name)
      redirect_to studynote
    else
      flash.now[:alert] = t(:item_not_updated, item: name)
      locals :edit, studynote:
    end
  end

  # :reek:TooManyStatements
  def save_studynote
    name = Studynote.model_name.human
    if studynote.save
      @studynote.tag_list.add @tag_list
      flash[:notice] = t(:item_created, item: name)
      redirect_to studynote
    else
      flash.now[:alert] = t(:item_not_created, item: name) + "reden" +
        studynote.pericopes[0].errors.full_messages[0]
      locals :edit, studynote:
    end
  end

  def studynote_params
    params.require(:studynote).permit(
      :id,
      :title,
      :note,
      :tag_list,
      pericopes_attributes: %i[id name _destroy tag_list]
    )
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynotes_path
  end
end
