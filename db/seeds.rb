# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Deleting all of it!'
User.destroy_all
Plug.destroy_all
Review.destroy_all
Booking.destroy_all
puts 'Generating new Data...'

# this is the data used to generate everything
# its exactly 8 per category because there are always 8 records per table!
@addresses = ["Brienner Str. 50, München", "Königsplatz 1, München", "Neuhauser Straße 27, München", "Kardinal-Faulhaber-Straße 1, München", "Rosental 9, München", "Hohenzollernstraße 103, 80796 München", "Rosenheimer Str. 90, 81669 München", "Claudius-Keller-Straße 2, 81669 München"]
@descriptions = ["Just got this new baby! Its located in my garage, please ask for keys...", "It's powered with solar energy, so don't come here at night", "Rooftop charger with beatiful view over munich skyline", "If you're hot you can drive my i8 while your car is charging (he/him)", "Pleeease DON'T bring all of your friends guys!!!", " helo jus bought charger ! plesa charg so i can buy carr soon e", "Just here to ask what happened to airbnfight??", "'Roses are red, violets are blue. The charger is speaking. I'm waiting for you!'"]
# For personal data, always the last four is one of us
@first_names = ["Mike", "Joe", "Justin", "Hugh", "Jonas", "Leopold", "Adam", "Benjamin"]
@last_names = ["Oxlong", "Mamer", "Credible", "Jass", "Stannowski", "Huelst", "Kerr", "Dohna"]
@emails = ["mike@oxlong.com", "joe@mamer.com", "justin@credible.com", "hugh@jazz.com", "jonas@stannowski.com", "leopold@huelst.com", "adam@kerr.com", "benjamin@dohna.com"]
# this is the counter that counts through all the seeding process for index purposes
@index = rand(-8..0)
# youll understand that later (its for uniqe booking creation)
@users = []
@plugs = []

8.times do

  @users << user = User.create!(
    first_name: @first_names[@index],
    last_name: @last_names[@index],
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
    plug_type: rand(1..2),
    email: @emails[@index],
    password: "123456"
  )
  @plugs << Plug.create!(
    plug_type: rand(1..2),
    location: @addresses[@index],
    # availability 0 means available, 1 means it is booked
    availability: [0, 1].sample,
    description: @descriptions[@index],
    fixed_cost_per_15_min: rand(0.05..1).round(2),
    user: user
  )

  # to go along the array:
  @index += 1
end

# to prevent that one booking has same user
loop do
  p @index2 = rand(-8..7)
  p @index = rand(-8..7)
  break if @index2 != @index
end

# first 8 are good, second 8 are bad
@reviews = ["This Car Charger works very well. It persistently improves my flirting skills by a lot.", "Handsome young lad. Went for a date while his car was charged <3",  "this Car Charger is light-hearted.", "Handsome dude. was talking to the charger but whatever. liked him", "Great charger! My velociraptor looves to play with it :)", "he was totally on drugs but I had a lot of fun watching him so...", "This Car Charger, does exactly what it's suppose to do.", "This man did exactly what he was supposed to do",
            "Owner said password was 'Chickendick334', but charger only had numbers!??", "I get bad review... I send bad review", "it only works when i pet it !", "touched my charger all over again... had to call the cops this time smh", "Charger is suspicious. After I use it, my car only drives backwards", "When he arrived he hit my letter box so I hacked his car to drive backwards lmaooo", "tried to charge my phone and now its broken. please repair ASAp dude", "This is a CAR charger. stop trying to charger your PHONE man. STOP IT!",]
# index for reviews because we need 16 (one for user and provider per booking)
@index_r = 0

8.times do

  booking = Booking.create!(
    user: @users[@index],
    # status 0 means the booking is current and not over yet; status 1 means its over
    status: 1,
    duration: rand(1..10),
    plug: @plugs[@index2],
    cost: rand(2..25)
  )

  @index += 1
  @index = 0 if @index == 8
  @index2 += 1
  @index2 = 0 if @index2 == 8

  # reviewtype 1 is a review for user by owner, review type 0 is a review for owner by user
  [0, 1].each do |number|

    # again... first 8 are good, second 8 are bad
    if @index_r < 9
      rating = [4, 5].sample
    else
      rating = [1, 2].sample
    end
    Review.create!(
      rating: rating,
      contents: @reviews[@index_r],
      review_type: number,
      booking: booking
    )
    @index_r += 1

  end

end

puts 'Data generated, you Monkey!'


# @contents = ["Sweet plug! Got the charge I needed thanks!", "Not bad, wasnt a fan of the aggresive elephant blocking the driveway", "Cool charger! Almost electrocuted myself because I'm a moron, but thanks anyway!"]
# @description = ["The charger is located on the outside of the garage, please watchout for the super aggresive elephant.", "The charger cable is 10m long so you shouldn't have any issues. Also, there is an extremely aggresive ninja turtle to watch out for.", "Please hang the charger back up when you are done with it as my dog likes to chew on the cable. Thanks!"]

# @dates = ["2021-11-25", "2021-10-23", "2021-11-01", "2021-11-18", "2021-09-27", "2021-10-13", "2021-10-30", "2021-11-12", "2021-11-09", "2021-11-14"]
# User.create!(
#   first_name: "Joe",
#   last_name: "Mama",
#   birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
#   plug_type: rand(1..2),
#   email: Faker::Internet.email,
#   password: "123456"
# )

# @addresses.each do |address|
#   users = [User.first]
#   @index = 0
#   users << user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
#     plug_type: rand(1..2),
#     email: Faker::Internet.email,
#     password: "123456"
#   )
#   plug = Plug.create!(
#     plug_type: rand(1..2),
#     location: address,
#     availability: [0, 1].sample,
#     description: @description.sample,
#     fixed_cost_per_15_min: rand(1..6),
#     user: users[@index]
#   )

#   booking = Booking.create!(
#     user: user,
#     status: 1,
#     duration: rand(1..10),
#     plug: plug,
#     cost: rand(2..25)
#   )
#   [0, 0, 1].each do |number|
#     Review.create!(
#       rating: rand(1..5),
#       contents: @contents.sample,
#       review_type: number,
#       booking: booking
#     )
#   end
#   @index += 1
# end

# # for login purpose:

# user1 = User.create!(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
#   plug_type: rand(1..2),
#   email: "jesus@rippin.com",
#   password: "123456"
# )

# user2 = User.create!(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
#   plug_type: rand(1..2),
#   email: "jesus@drippin.com",
#   password: "123456"
# )

# plug = Plug.create!(
#   plug_type: rand(1..2),
#   location: "Bayerstraße 12, München",
#   availability: [0, 1].sample,
#   description: @description.sample,
#   fixed_cost_per_15_min: rand(1..6),
#   user: user2
# )
# booking = Booking.create!(
#   user: user1,
#   status: 1,
#   duration: rand(15..180),
#   plug: plug,
#   cost: rand(2..25)
# )
# [0, 0, 1].each do |number|
#   Review.create!(
#     rating: rand(1..5),
#     contents: @contents.sample,
#     review_type: number,
#     booking: booking
#   )
# end

# plug = Plug.create!(
#   plug_type: rand(1..2),
#   location: "Bayerstraße 12, München",
#   availability: [0, 1].sample,
#   description: @description.sample,
#   fixed_cost_per_15_min: rand(1..6),
#   user: user1
# )

# booking = Booking.create!(
#   user: user2,
#   status: 1,
#   duration: rand(15..180),
#   plug: plug,
#   cost: rand(2..25)
# )

# [0, 0, 1].each do |number|
#   Review.create!(
#     rating: rand(1..5),
#     contents: @contents.sample,
#     review_type: number,
#     booking: booking
#   )
# end

# # user without anything

# User.create!(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
#   plug_type: rand(1..2),
#   email: "jesus@flippin.com",
#   password: "123456"
# )
