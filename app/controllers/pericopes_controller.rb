class PericopesController < ApplicationController
  def index
    @ot = Biblebook.where(testament: "oud"  ).select("name")
    @nt = Biblebook.where(testament: "nieuw").select("name")

    @biblebook_counts = Pericope.group(:biblebook_name).count
  end
end
