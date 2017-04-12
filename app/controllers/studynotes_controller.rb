class StudynotesController < ApplicationController

  before_action :authenticate_user!, only: [:new,        :create, :edit, :update, :destroy]
  before_action :set_studynote,      only: [      :show,          :edit, :update, :destroy]

  def index
    @studynote = Studynote.all.order(:title)
  end

  def show
  end

  def new
    @studynote = Studynote.new
    @studynote_to_publish = @studynote.pericopes.build
  end

  def create
    @studynote_to_publish = Pericope.new
    @studynote = Studynote.new(studynote_params)
    @studynote.author = current_user

    if @studynote.save
      flash[:notice] = t(:item_created, item: Studynote.model_name.human)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:item_not_created, item: Studynote.model_name.human)
      render 'new'
    end
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
    @studynote.destroy
    flash[:notice] = t('activerecord.messages.deleted', model: 'bijbelstudie')
    redirect_to pericopes_path
  end

  private

  def studynote_params
    params.require(:studynote).permit(:id, :title, :note, pericopes_attributes: [:id, :name])
  end

  def pericope_params
    params.require(:studynote_to_publish).permit(pericopes_attributes: [:name, :id])
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynotes_path
  end
end
