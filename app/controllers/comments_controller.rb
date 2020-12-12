# frozen_string_literal: true
# Controller for handlings Comments on Studynotes

class CommentsController < ApplicationController
  before_action :set_studynote
  before_action :set_comment, only: [:show]

  def new
    @comment = @studynote.comments.build
  end

  def create
    @comment = @studynote.comments.build(comment_params)
    if @comment.save
      flash[:notice] = 'Comment has been created.'
      redirect_to @studynote
    else
      flash.now[:alert] = 'Comment has not been created.'
      render 'new'
    end
  end

  def show; end

  private

  def set_studynote
    @studynote = Studynote.find(params[:studynote_id])
  end

  def comment_params
    params.require(:comment).permit(:description)
  end

  def set_comment
    @comment = @studynote.comments.find(params[:id])
  end
end
