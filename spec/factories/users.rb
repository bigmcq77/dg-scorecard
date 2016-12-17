FactoryGirl.define do
  factory :user do
    name 'Nate Sexton'
    email 'nsexton@email.com'
    password 'password'
    password_confirmation 'password'
  end
end
