# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'deleting data'
puts 'generating data'

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
    gender: ['male', 'female'].sample,
    plug_type: rand(1..2),
    email: Faker::Internet.email,
    password: "123456"
  )
  plug = Plug.create!(
    plug_type: rand(1..2),
    location: Faker::Address.full_address,
    availability: Faker::Date.between(from: '2020-03-17', to: '2021-11-11'),
    description: Faker::Lorem.paragraph,
    fixed_cost_per_15_min: rand(1..6),
    user: user
  )
  booking = Booking.create!(
    user: user,
    status: [0, 1].sample,
    duration: rand(1..10),
    date_time: Faker::Date.between(from: '2020-03-17', to: '2021-11-11'),
    plug: plug
  )
  [0, 0, 1].each do |number|
    Review.create!(
      rating: rand(1..5),
      contents: Faker::Quote.famous_last_words,
      review_type: number,
      booking: booking
    )
  end
end

puts 'data generated you monkey!'
