# Create a user
user = User.create(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: "password",
                   password_confirmation: "password")

User.create(name: "Matthew McQuinn",
            email: "mmcquinn77@gmail.com",
            password: "password",
            password_confirmation: "password")


# Create a course
c = Course.create(name: Faker::Company.name,
                  num_holes: 18)

# Create 18 holes for the course
18.times do |i|
  Hole.create(course: c, number: i+1, par: Faker::Number.between(3,5))
end

# Create a round
r = Round.create(user: user, course: c, weather: "Sunny")

# Create 18 random scores
18.times do |i|
  Score.create(round: r, hole: Hole.find(i+1), strokes: Faker::Number.between(1,6))
end

# Create a par round
par_round = Round.create(user: user, course: c, weather: "Rainy")
18.times do |i|
  Score.create(round: par_round, hole: Hole.find(i+1), strokes: Hole.find(i+1).par)
end

# create a bogey round
bogey_round = Round.create(user: user, course: c, weather: "Rainy")
18.times do |i|
  Score.create(round: bogey_round, hole: Hole.find(i+1), strokes: Hole.find(i+1).par+1)
end
