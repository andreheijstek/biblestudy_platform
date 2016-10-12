class StudynotesController < ApplicationController

  before_action :set_studynote, only: [:show, :edit, :update, :destroy]

  def index
    @studynote = Studynote.all.order(:title)
  end

  def new
    @studynote = Studynote.new
    @pericope = @studynote.pericopes.build
  end

  def create
    @pericope = Pericope.new
    @studynote = Studynote.new(studynote_params)
    @studynote.author = current_user

    if @studynote.save
      flash[:notice] = t(:studynote_created)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:studynote_not_created)
      render 'new'
    end
  end

  def show
    # authorize @studynote, :show?
  end

  def edit
  end

  def update
    if @studynote.update(studynote_params)
      flash[:notice] = t(:studynote_updated)
      redirect_to @studynote
    else
      flash.now[:alert] = t(:studynote_not_updated)
      render 'edit'
    end
  end

  def destroy
    @studynote.destroy
    flash[:notice] = t(:studynote_deleted)
    redirect_to studynotes_path
  end

  private

  def studynote_params
    params.require(:studynote).permit(:id, :title, :note, pericopes_attributes: [:id, :name])
  end

  def pericope_params
    params.require(:pericope).permit(pericopes_attributes: [:name, :id])
  end

  def set_studynote
    @studynote = Studynote.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:studynote_not_found)
    redirect_to studynotes_path
  end
end
