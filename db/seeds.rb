# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'deleting data'
User.destroy_all
Plug.destroy_all
Review.destroy_all
Booking.destroy_all
puts 'generating data'
@contents = ["Sweet plug! Got the charge I needed thanks!", "Not bad, wasnt a fan of the aggresive elephant blocking the driveway", "Cool charger! Almost electrocuted myself because I'm a moron, but thanks anyway!"]
@description = ["The charger is located on the outside of the garage, please watchout for the super aggresive elephant.", "The charger cable is 10m long so you shouldn't have any issues. Also, there is an extremely aggresive ninja turtle to watch out for.", "Please hang the charger back up when you are done with it as my dog likes to chew on the cable. Thanks!"]
@addresses = ["Brienner Str. 50, München", "Königsplatz 1, München", "Neuhauser Straße 27, München", "Kardinal-Faulhaber-Straße 1, München", "Rosental 9, München", "Hohenzollernstraße 103, 80796 München", "Rosenheimer Str. 90, 81669 München", "Claudius-Keller-Straße 2, 81669 München", "Plinganserstraße 19, 81369 München", "Meglingerstraße 6, 81477 München", "Fürstenrieder Str. 54, 80686 München", "Kapuzinerstraße 8, 80337 München" ]
@dates = ["2021-11-25", "2021-10-23", "2021-11-01", "2021-11-18", "2021-09-27", "2021-10-13", "2021-10-30", "2021-11-12", "2021-11-09", "2021-11-14"]
User.create!(
  first_name: "Joe",
  last_name: "Mama",
  birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
  plug_type: rand(1..2),
  email: Faker::Internet.email,
  password: "123456"
)

@addresses.each do |address|
  users = [User.first]
  @index = 0
  users << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
    plug_type: rand(1..2),
    email: Faker::Internet.email,
    password: "123456"
  )
  plug = Plug.create!(
    plug_type: rand(1..2),
    location: address,
    availability: [0, 1].sample,
    description: @description.sample,
    fixed_cost_per_15_min: rand(1..6),
    user: users[@index]
  )

  booking = Booking.create!(
    user: user,
    status: 1,
    duration: rand(1..10),
    plug: plug,
    cost: rand(2..25)
  )
  [0, 0, 1].each do |number|
    Review.create!(
      rating: rand(1..5),
      contents: @contents.sample,
      review_type: number,
      booking: booking
    )
  end
  @index += 1
end

# for login purpose:

user1 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
  plug_type: rand(1..2),
  email: "jesus@rippin.com",
  password: "123456"
)

user2 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
  plug_type: rand(1..2),
  email: "jesus@drippin.com",
  password: "123456"
)

plug = Plug.create!(
  plug_type: rand(1..2),
  location: "Bayerstraße 12, München",
  availability: [0, 1].sample,
  description: @description.sample,
  fixed_cost_per_15_min: rand(1..6),
  user: user2
)
booking = Booking.create!(
  user: user1,
  status: 1,
  duration: rand(15..180),
  plug: plug,
  cost: rand(2..25)
)
[0, 0, 1].each do |number|
  Review.create!(
    rating: rand(1..5),
    contents: @contents.sample,
    review_type: number,
    booking: booking
  )
end

plug = Plug.create!(
  plug_type: rand(1..2),
  location: "Bayerstraße 12, München",
  availability: [0, 1].sample,
  description: @description.sample,
  fixed_cost_per_15_min: rand(1..6),
  user: user1
)

booking = Booking.create!(
  user: user2,
  status: 1,
  duration: rand(15..180),
  plug: plug,
  cost: rand(2..25)
)

[0, 0, 1].each do |number|
  Review.create!(
    rating: rand(1..5),
    contents: @contents.sample,
    review_type: number,
    booking: booking
  )
end

# user without anything

User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
  plug_type: rand(1..2),
  email: "jesus@flippin.com",
  password: "123456"
)

puts 'data generated you monkey!'
