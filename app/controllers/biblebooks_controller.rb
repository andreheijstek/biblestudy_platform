class BiblebooksController < ApplicationController
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
    @biblebook = Biblebook.find(params[:id])
  end

  def edit
    @biblebook = Biblebook.find(params[:id])
  end

  def update
    @biblebook = Biblebook.find(params[:id])
    if @biblebook.update(biblebook_params)
      flash[:notice] = "Biblebook has been updated."
      redirect_to @biblebook
    else
      flash.now[:alert] = "Biblebook has not been updated."
      render "edit"
    end
  end

  def destroy
    @biblebook = Biblebook.find(params[:id])
    @biblebook.destroy
    flash[:notice] = "Biblebook has been deleted."
    redirect_to biblebooks_path
  end

  private

  def biblebook_params
    params.require(:biblebook).permit(:name, :description)
  end
end
