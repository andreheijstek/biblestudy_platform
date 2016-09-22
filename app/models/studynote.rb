class Studynote < ActiveRecord::Base
  has_many :pericopes, dependent: :destroy
  has_many :biblebooks, through: :pericopes

  accepts_nested_attributes_for :pericopes

  validates :note,  presence: true
  validates :title, presence: true
end
