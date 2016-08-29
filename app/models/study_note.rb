class StudyNote < ActiveRecord::Base
  has_many :pericopes, inverse_of: :study_note

  accepts_nested_attributes_for :pericopes
end
