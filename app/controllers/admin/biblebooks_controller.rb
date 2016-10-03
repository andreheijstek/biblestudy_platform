class Admin::BiblebooksController < Admin::ApplicationController
  before_action :set_biblebook, only: [:show, :edit, :update, :destroy]

  def index
    @biblebook = Biblebook.all
  end

  def new
    @biblebook = Biblebook.new
  end

  def create
    @biblebook = Biblebook.new(biblebook_params)
    if @biblebook.save
      flash[:notice] = t(:biblebook_created)
      redirect_to [:admin, @biblebook]
    else
      flash.now[:alert] = t(:biblebook_not_created)
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @biblebook.update(biblebook_params)
      flash[:notice] = t(:biblebook_updated)
      redirect_to [:admin, @biblebook]
    else
      flash.now[:alert] = t(:biblebook_not_updated)
      render "edit"
    end
  end

  def destroy
    @biblebook.destroy
    flash[:notice] = t(:biblebook_deleted)
    redirect_to admin_biblebooks_path
  end

  private

  def biblebook_params
    params.require(:biblebook).permit(:name, :booksequence, :testament)
  end

  def set_biblebook
    @biblebook = Biblebook.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:biblebook_not_found)
    redirect_to admin_biblebooks_path
  end
end
