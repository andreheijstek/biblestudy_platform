# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  studynote_id :integer
#

# Models a Role for a User
class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :studynote
end
