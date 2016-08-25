class Pericope < ActiveRecord::Base
  belongs_to :book
  belongs_to :starting_chapter
  belongs_to :ending_chapter
end
