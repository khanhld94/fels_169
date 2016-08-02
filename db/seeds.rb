10.times do |s|
  name = Faker::App.name
  description = Faker::Lorem.sentence
  Category.create! name: name, description: description
end
