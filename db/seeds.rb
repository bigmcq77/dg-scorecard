user = User.create(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: "password",
                   password_confirmation: "password")

c = Course.create(name: Faker::Company.name,
                  num_holes: 18)

18.times do |i|
  Hole.create(course: c, number: i+1, par: Faker::Number.between(3,5))
end
