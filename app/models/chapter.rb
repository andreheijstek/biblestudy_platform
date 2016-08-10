class Chapter < ActiveRecord::Base
  belongs_to :biblebook
  has_many :verses

  validates :chapter_number, presence: true

  default_scope { order('chapter_number ASC') }

end
