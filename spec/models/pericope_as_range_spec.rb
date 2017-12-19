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

require 'rails_helper'

RSpec.describe PericopeAsRange, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
