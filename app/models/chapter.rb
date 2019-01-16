# frozen_string_literal: true

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

# Models a Chapter within a Biblebook
class Chapter < ActiveRecord::Base
  belongs_to :biblebook

  validates :chapter_number, presence: true

  # Spaceship to help Comparable methods
  def <=> (other)
    self.chapter_number <=> other.chapter_number
  end
end
