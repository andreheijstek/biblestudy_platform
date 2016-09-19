class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook
  validates_with PericopeValidator
end

