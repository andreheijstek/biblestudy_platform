# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id             :integer          not null, primary key
#  chapter_number :integer
#  description    :string
#  nrofverses     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  biblebook_id   :integer
#
# Indexes
#
#  index_chapters_on_biblebook_id  (biblebook_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#

# Models a Chapter within a Biblebook
class Chapter < ActiveRecord::Base
  include Comparable

  belongs_to :biblebook

  validates :chapter_number, presence: true

  # Spaceship to help Comparable methods
  def <=>(other)
    chapter_number <=> other.chapter_number
  end
end
