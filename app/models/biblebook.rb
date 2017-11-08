# frozen_string_literal: true
# == Schema Information
#
# Table name: biblebooks
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  booksequence :integer
#  testament    :string
#  abbreviation :string
#

class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters, dependent: :delete_all
  has_many :pericopes
  has_many :studynotes, through: :pericopes

  default_scope { order("booksequence ASC") }

  def chapter_valid?(chapter)
    chapter > 0 && chapter <= nr_of_chapters
  end

  def nr_of_chapters
    Chapter.where(biblebook_id: self.id).count
  end
end
