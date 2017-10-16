# The caller should create the correct biblebook before calling Pericope_xxx_Factory

FactoryGirl.define do
  factory :pericope, class: Pericope do
    name 'Jona 1:1 - 1:10'
    trait :jona do
      biblebook do
        Biblebook.find_by(name: 'Jona') || FactoryGirl.create(:biblebook, name: 'Jona')
      end
    end
  end
end
