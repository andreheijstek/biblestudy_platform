class Studynote < ActiveRecord::Base
  has_many :pericopes, inverse_of: :studynote

  accepts_nested_attributes_for :pericopes

  # validates :title, :note, presence: true
end
