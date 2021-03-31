# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  studynote_id :integer
#  user_id      :integer
#
# Indexes
#
#  index_roles_on_studynote_id  (studynote_id)
#  index_roles_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (studynote_id => studynotes.id)
#  fk_rails_...  (user_id => users.id)
#

# Models a Role for a User
class Role < ApplicationRecord
  belongs_to :user
  belongs_to :studynote
end
