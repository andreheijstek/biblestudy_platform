class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters, dependent: :delete_all

  default_scope { order('booksequence ASC') }
end
