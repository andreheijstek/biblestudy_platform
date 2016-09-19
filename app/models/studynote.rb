class Studynote < ActiveRecord::Base
  has_many :pericopes, inverse_of: :studynote
  has_many :biblebooks, through: :pericopes

  # accepts_nested_attributes_for :pericopes

  # validates :title, :note, presence: true
end
