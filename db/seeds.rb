# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Reservation.destroy_all
Listing.destroy_all
User.destroy_all
City.destroy_all


all_users = []
all_cities = []
all_listings = []
all_past_reservations = []
all_future_reservations = []

20.times do
  all_users << User.create(phone_number: Faker::PhoneNumber.phone_number , email: Faker::Internet.email, description: Faker::Lorem.sentence(word_count: 10))
end

10.times do
  all_cities << City.create(city_name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

# Generate a random number between 0 and 1
def random_boolean
  rand(0..1) == 1
end

50.times do
  all_listings << Listing.create(available_beds: rand(1..3), price: rand(50..150), description: Faker::Lorem.sentence(word_count: 7), has_wifi: random_boolean, welcome_message: Faker::Lorem.word, admin: all_users.sample, city: all_cities.sample)
end

all_listings.each do |listing|
  5.times do # past
    all_past_reservations << Reservation.create(start_date: Faker::Date.backward(days: rand(201..365)), end_date: Faker::Date.backward(days: rand(1..200)), already_booked: false, guest: all_users.sample, listing: all_listings.sample)
  end
  5.times do # future
    all_future_reservations << Reservation.create(start_date: Faker::Date.forward(days: rand(1..200)), end_date: Faker::Date.forward(days: rand(201..365)), already_booked: false, guest: all_users.sample, listing: all_listings.sample)
  end
end