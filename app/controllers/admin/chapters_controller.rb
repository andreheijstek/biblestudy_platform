class Admin::ChaptersController < Admin::ApplicationController
  before_action :set_biblebook
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @chapter = @biblebook.chapters.build
  end

  def create
    @chapter = @biblebook.chapters.build(chapter_params)
    if @chapter.save
      flash[:notice] = t(:item_created, item: Chapter.model_name.human)
      redirect_to [:admin, @biblebook, @chapter]
    else
      flash.now[:alert] = t(:item_not_created, item: Chapter.model_name.human)
      render "new"
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      flash[:notice] = t(:item_updated, item: Chapter.model_name.human)
      redirect_to [:admin, @biblebook, @chapter]
    else
      flash.now[:alert] = t(:item_not_updated, item: Chapter.model_name.human)
      render "edit"
    end
  end

  def destroy
    @chapter.destroy
    flash[:notice] = t(:item_deleted, item: Chapter.model_name.human)
    redirect_to [:admin, @biblebook]
  end

  private
  
  def chapter_params
    params.require(:chapter).permit(:chapter_number, :description, :nrofverses)
  end

  def set_biblebook
    @biblebook = Biblebook.find(params[:biblebook_id])
  end

  def set_chapter
    @chapter = @biblebook.chapters.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(:chapter_not_found)
    redirect_to admin_biblebook_chapters_path
  end
end
