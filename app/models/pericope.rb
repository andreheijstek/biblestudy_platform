class Pericope < ActiveRecord::Base
  belongs_to :studynote
  has_one :biblebook
  validates_with PericopeValidator
end

