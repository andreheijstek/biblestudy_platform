# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#
# Indexes
#
#  index_studynotes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#

# Models a Studynote, the main Object for this application
class Studynote < ActiveRecord::Base
  has_many :pericopes, inverse_of: :studynote, dependent: :destroy
  # accepts_nested_attributes_for :pericopes,
  #                               allow_destroy: true,
  #                               reject_if: :all_blank
  accepts_nested_attributes_for :pericopes,
                                allow_destroy: true,
                                reject_if: RejectDeeplyNested.blank?

  has_many :biblebooks, through: :pericopes
  has_many :roles, dependent: :delete_all

  belongs_to :author, class_name: 'User'

  delegate :username, to: :author, prefix: true
  delegate :email, to: :author, prefix: true

  validates :note,  presence: true
  validates :title, presence: true
end
