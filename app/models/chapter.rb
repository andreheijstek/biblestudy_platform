# == Schema Information
#
# Table name: chapters
#
#  id             :integer          not null, primary key
#  chapter_number :integer
#  description    :string
#  biblebook_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nrofverses     :integer
#

class Chapter < ActiveRecord::Base
  belongs_to :biblebook

  validates :chapter_number, presence: true

  # default_scope { order("chapter_number ASC") }
end
