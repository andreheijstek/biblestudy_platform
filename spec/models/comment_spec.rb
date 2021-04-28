# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  studynote_id :bigint
#
# Indexes
#
#  index_comments_on_studynote_id  (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (studynote_id => studynotes.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
