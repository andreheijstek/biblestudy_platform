class Studynote < ActiveRecord::Base
  has_many :pericopes
  has_many :biblebooks, through: :pericopes
  accepts_nested_attributes_for :pericopes
end
