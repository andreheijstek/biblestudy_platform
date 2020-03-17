# frozen_string_literal: true

# == Schema Information
#
# Table name: bibleverses
#
#  id         :bigint           not null, primary key
#  chapter    :integer
#  verse      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Bibleverse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
