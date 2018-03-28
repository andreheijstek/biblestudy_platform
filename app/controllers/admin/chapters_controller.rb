# frozen_string_literal: true

module Admin
  # Controller for Chapters
  # Handling the typical CRUD actions
  class ChaptersController < Admin::ApplicationController
    before_action :set_biblebook
    before_action :set_chapter, only: %i[show edit update destroy]

    def show; end

    def new
      @chapter = @biblebook.chapters.build
    end

    def create
      @chapter = @biblebook.chapters.build(chapter_params)
      save_chapter
    end

    def edit; end

    def update
      name = Chapter.model_name.human
      if @chapter.update(chapter_params)
        flash[:notice] = t(:item_updated, item: name)
        redirect_to [:admin, @biblebook, @chapter]
      else
        flash.now[:alert] = t(:item_not_updated, item: name)
        render 'edit'
      end
    end

    def destroy
      @chapter.destroy
      flash[:notice] = t(:item_deleted, item: Chapter.model_name.human)
      redirect_to [:admin, @biblebook]
    end

    private

    def save_chapter
      name = Chapter.model_name.human
      if @chapter.save
        flash[:notice] = t(:item_created, item: name)
        redirect_to [:admin, @biblebook, @chapter]
      else
        flash.now[:alert] = t(:item_not_created, item: name)
        render 'new'
      end
    end

    def chapter_params
      params.require(:chapter).permit(:chapter_number,
                                      :description,
                                      :nr_of_verses)
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
end
