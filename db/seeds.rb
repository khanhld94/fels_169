User.create name: "admin", email: "admin@gmail.com", role: 1,
  password: "123123", password_confirmation: "123123"
User.create name: "user", email: "user@gmail.com", role: 0,
  password: "123123", password_confirmation: "123123"

10.times do |s|
  name = Faker::App.name
  description = Faker::Lorem.sentence
  Category.create! name: name, description: description
end

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "12345678"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, role: 0
end
