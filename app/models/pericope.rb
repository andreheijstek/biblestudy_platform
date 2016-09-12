class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook
  validates_with PericopeValidator
end

