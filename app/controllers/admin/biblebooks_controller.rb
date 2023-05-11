# frozen_string_literal: true

module Admin
  # Controller for Biblebooks
  # Handling the typical CRUD actions
  class BiblebooksController < Admin::ApplicationController
    before_action :set_biblebook, only: %i[show edit update destroy]

    attr_reader :biblebook

    # Gets all biblebooks to be used in views
    def index
      biblebook = Biblebook.all
      locals biblebook:
    end

    # Default show - no code needed
    def show; end

    # Creates a new Biblebook
    def new
      biblebook = Biblebook.new
      locals :new, biblebook:
    end

    # Creates and saves a new Biblebook
    def create
      @biblebook = Biblebook.new(biblebook_params)
      save_biblebook
    end

    # Default edit - no code needed
    def edit; end

    # Updates existing Biblebook
    def update
      update_biblebook
    end

    # Deletes existing Biblebook
    def destroy
      biblebook.destroy
      flash[:notice] = t('errors.messages.biblebook_deleted')
      redirect_to admin_biblebooks_path
    end

    private

    def update_biblebook
      name = Biblebook.model_name.human
      if biblebook.update(biblebook_params)
        flash[:notice] = t(:item_updated, item: name)
        redirect_to [:admin, biblebook]
      else
        flash.now[:alert] = t(:item_not_updated, item: name)
        render 'edit'
      end
    end

    def save_biblebook
      name = Biblebook.model_name.human
      if biblebook.save
        flash[:notice] = t(:item_created, item: name)
        redirect_to [:admin, biblebook]
      else
        flash.now[:alert] = t(:item_not_created, item: name)
        locals :new, biblebook:
      end
    end

    def biblebook_params
      params.require(:biblebook).permit(:name, :booksequence, :testament)
    end

    def set_biblebook
      @biblebook = Biblebook.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('errors.messages.biblebook_not_found')
      redirect_to admin_biblebooks_path
    end
  end
end
