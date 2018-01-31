50.times do
user = User.create(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: "password",
                   password_confirmation: "password")
end
