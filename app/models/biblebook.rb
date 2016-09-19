class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters, dependent: :delete_all
  has_many :studynotes, through: :pericopes

  # default_scope { order('booksequence ASC') }
end
