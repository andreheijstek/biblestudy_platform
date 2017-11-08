# frozen_string_literal: true
# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  role         :string
#  studynote_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :studynote
end
