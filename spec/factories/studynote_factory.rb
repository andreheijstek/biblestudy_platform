=begin
FactoryGirl.define do
  factory :study_note do
    title "titel"
    note "text"
    FactoryGirl.create(:pericope_by_name, name: 'Handelingen 1:2 - 3:4')
  end
end
=end
