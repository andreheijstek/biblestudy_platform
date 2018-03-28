# frozen_string_literal: true

module Admin
  # Controller for Biblebooks
  # Handling the typical CRUD actions
  class BiblebooksController < Admin::ApplicationController
    before_action :set_biblebook, only: %i[show edit update destroy]

    attr_reader :biblebook

    def index
      biblebook = Biblebook.all
      locals biblebook: biblebook
    end

    def show; end

    def new
      biblebook = Biblebook.new
      locals :new,  biblebook: biblebook
    end

    def create
      biblebook = Biblebook.new(biblebook_params)
      save_biblebook(biblebook)
    end

    def edit; end

    def update
      name = Biblebook.model_name.human
      update_biblebook(name)
    end

    def destroy
      biblebook.destroy
      flash[:notice] = t(:biblebook_deleted)
      redirect_to admin_biblebooks_path
    end

    private

    def update_biblebook(name)
      if biblebook.update(biblebook_params)
        flash[:notice] = t(:item_updated,
                           item: name)
        redirect_to [:admin, biblebook]
      else
        flash.now[:alert] = t(:item_not_updated,
                              item: name)
        render 'edit'
      end
    end

    def save_biblebook(biblebook)
      name = Biblebook.model_name.human
      if biblebook.save
        flash[:notice] = t(:item_created,
                           item: name)
        redirect_to [:admin, biblebook]
      else
        flash.now[:alert] = t(:item_not_created,
                              item: name)
        locals :new, biblebook: biblebook

      end
    end

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
end
