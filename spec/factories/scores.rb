FactoryGirl.define do
  factory :score do
    association :round
    association :hole
    strokes 3
  end
end
