class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook
  # validates :name, presence: true
  # after_validation :parse_name
  validates_with PericopeValidator
end
