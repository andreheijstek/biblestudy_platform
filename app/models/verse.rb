class Verse < ActiveRecord::Base
  belongs_to :chapter

  validates :verse_number, presence: true

end
