# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  author_id  :integer
#

class Studynote < ActiveRecord::Base
  has_many :pericopes, dependent: :destroy
  has_many :biblebooks, through: :pericopes
  has_many :roles, dependent: :delete_all

  belongs_to :author, class_name: 'User'

  accepts_nested_attributes_for :pericopes, reject_if: :all_blank

  validates :note,  presence: true
  validates :title, presence: true
end
