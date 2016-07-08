class Biblebook < ActiveRecord::Base
  validates :name, presence: true
end
