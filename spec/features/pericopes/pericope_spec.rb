# frozen_string_literal: true
# require 'rails_helper'
#
# feature 'Users can delete pericopes' do
#   let(:user) { create(:user) }
#   let(:studynote) { create(:studynote,
#                            pericope: 'Jona 1:1-5',
#                            title: 'Jona met 1 pericoop',
#                            note: 'zomaar iets')}
#
#   before do
#     create(:biblebook, name: 'Jona')
#     login_as(user)
#     visit studynotes_path
#     click_link t(:new_studynote)
#   end
#
#   scenario 'pericopes' do
#
#     it 'should be possible to delete a pericope' do
#       # vooraf moet er al een sn met 2 pericopen zijn (let)
#       # daar ga ik naartoe, visit :deze_sn
#       # daarvan delete ik er 1 (pericoop)
#       # dat moet dan goed gaan, dus in de show zie ik nog maar 1 pericoop, message=succes
#       expect(true).to eq(false)
#     end
#
#     it 'should not be possible to delete the only pericope' do
#
#     end
# end
