# frozen_string_literal: true

module Admin
  # Controller for Chapters
  # Handling the typical CRUD actions
  class ChaptersController < Admin::ApplicationController
    before_action :set_biblebook
    before_action :set_chapter, only: %i[show edit update destroy]

    attr_reader :chapter, :biblebook

    # Gets the data to show one Chapter
    def show
      locals biblebook:, chapter:
    end

    # Creates a new Chapter
    def new
      chapter = biblebook.chapters.build
      locals chapter:
    end

    # Creates and saves a new Chapter within a Biblebook
    def create
      @chapter = biblebook.chapters.build(chapter_params)
      save_chapter
    end

    # Edits an existing Chapter
    def edit
      locals biblebook:, chapter:
    end

    # Updates an existing Chapter
    def update
      name = Chapter.model_name.human
      if chapter.update(chapter_params)
        flash[:notice] = t(:item_updated, item: name)
        redirect_to [:admin, biblebook, chapter]
      else
        flash.now[:alert] = t(:item_not_updated, item: name)
        render "edit"
      end
    end

    # Deletes an existing Chapter
    def destroy
      chapter.destroy
      flash[:notice] = t(:item_deleted, item: Chapter.model_name.human)
      redirect_to [:admin, biblebook]
    end

    private

    def save_chapter
      name = Chapter.model_name.human
      if chapter.save
        flash[:notice] = t(:item_created, item: name)
        redirect_to [:admin, biblebook, chapter]
      else
        flash.now[:alert] = t(:item_not_created, item: name)
        locals :new, biblebook:, chapter:
      end
    end

    def chapter_params
      params.require(:chapter).permit(
        :chapter_number,
        :description,
        :nr_of_verses
      )
    end

    def set_biblebook
      @biblebook = Biblebook.find(params[:biblebook_id])
    end

    def set_chapter
      @chapter = biblebook.chapters.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t(:chapter_not_found)
      redirect_to admin_biblebook_chapters_path
    end
  end
end
