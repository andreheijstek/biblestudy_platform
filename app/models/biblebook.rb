class Biblebook < ActiveRecord::Base
  validates :name, presence: true
  default_scope { order('booksequence ASC') }
end
