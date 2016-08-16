class Chapter < ActiveRecord::Base
  belongs_to :biblebook

  validates :chapter_number, presence: true

  default_scope { order('chapter_number ASC') }

end
