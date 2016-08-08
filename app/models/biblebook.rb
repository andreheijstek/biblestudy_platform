class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters

  default_scope { order('booksequence ASC') }
end
