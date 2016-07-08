class BiblebooksController < ApplicationController
  def index
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

  private

  def biblebook_params
    params.require(:biblebook).permit(:name, :description)
  end
end
