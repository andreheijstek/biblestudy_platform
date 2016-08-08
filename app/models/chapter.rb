class Chapter < ActiveRecord::Base
  belongs_to :biblebook

  validates :chapter_number, presence: true
end
