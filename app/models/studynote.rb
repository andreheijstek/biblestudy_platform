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

# Models a Studynote, the main Object for this application
class Studynote < ActiveRecord::Base
  has_many :pericopes, inverse_of: :studynote, dependent: :destroy
  accepts_nested_attributes_for :pericopes,
                                allow_destroy: true,
                                reject_if: :all_blank

  has_many :biblebooks, through: :pericopes
  has_many :roles, dependent: :delete_all

  belongs_to :author, class_name: 'User'

  validates :note,  presence: true
  validates :title, presence: true
end
