FactoryGirl.define do
  factory :hole do
    association :course
    number 1
    par 3
  end
end
