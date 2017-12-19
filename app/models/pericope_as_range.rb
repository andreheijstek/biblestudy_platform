# == Schema Information
#
# Table name: pericope_as_ranges
#
#  id                :integer          not null, primary key
#  name              :string
#  starting_verse_id :integer
#  ending_verse_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PericopeAsRange < ApplicationRecord
  belongs_to :starting_verse
  belongs_to :ending_verse
end
