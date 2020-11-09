# Commented
# TODO: move to page object model
# 
# # frozen_string_literal: true
#
# require 'rails_helper'
#
# # rubocop:disable RSpec/DescribeClass
# describe 'Users can only see the appropriate links' do
#   let(:user)  { create(:user) }
#   let(:admin) { create(:user, :admin) }
#
#   context 'with anonymous users' do
#     it 'cannot see the Admin link' do
#       visit '/'
#       expect(page).not_to have_link 'Admin'
#     end
#   end
#
#   context 'with regular users' do
#     before { login_as(user) }
#
#     it 'cannot see the Admin link' do
#       visit '/'
#       expect(page).not_to have_link 'Admin'
#     end
#   end
#
#   context 'with admin users' do
#     before { login_as(admin) }
#
#     it 'can see the Admin link' do
#       visit '/'
#       expect(page).to have_link 'Admin'
#     end
#   end
# end
# # rubocop:enable RSpec/DescribeClass
