# The caller should create the correct biblebook before calling Pericope_xxx_Factory

FactoryGirl.define do
  factory :pericope_by_name, class: Pericope do
    name 'Handelingen 1:2 - 3:4'
  end
end
