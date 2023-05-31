class StTagsController < ApplicationController
  def index
    @st_tags = StTag.order(:name)
  end
end
