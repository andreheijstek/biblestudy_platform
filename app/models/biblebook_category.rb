# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebook_categories
#
#  id           :bigint           not null, primary key
#  name         :string
#  order        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  biblebook_id :bigint
#
# Indexes
#
#  index_biblebook_categories_on_biblebook_id  (biblebook_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#

class BiblebookCategory < ApplicationRecord
end
