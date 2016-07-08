class BiblebooksController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @biblebook = Biblebook.all
  end

  def new
    @biblebook = Biblebook.new
  end

  def create
    @biblebook = Biblebook.new(biblebook_params)
    if @biblebook.save
      flash[:notice] = "Biblebook has been created."
      redirect_to @biblebook
    else
      flash.now[:alert] = "Biblebook has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @biblebook.update(biblebook_params)
      flash[:notice] = "Biblebook has been updated."
      redirect_to @biblebook
    else
      flash.now[:alert] = "Biblebook has not been updated."
      render "edit"
    end
  end

  def destroy
    @biblebook.destroy
    flash[:notice] = "Biblebook has been deleted."
    redirect_to biblebooks_path
  end

  private

  def biblebook_params
    params.require(:biblebook).permit(:name, :description)
  end

  def set_project
    @biblebook = Biblebook.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The biblebook you were looking for could not be found."
    redirect_to biblebooks_path
  end
end
