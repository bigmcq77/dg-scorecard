FactoryGirl.define do
  factory :round do
    association :user
    association :course
    weather "Sunny"
  end
end
