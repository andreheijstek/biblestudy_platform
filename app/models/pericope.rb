class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook
  has_one :starting_chapter
  has_one :ending_chapter
end
