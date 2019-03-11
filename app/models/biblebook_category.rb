# == Schema Information
#
# Table name: biblebook_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BiblebookCategory < ApplicationRecord
  belongs_to :biblebook
end
