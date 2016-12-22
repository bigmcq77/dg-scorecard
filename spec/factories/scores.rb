FactoryGirl.define do
  factory :score do
    association :round
    association :hole
    association :user
    strokes 3
  end
end
