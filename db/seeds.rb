# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
Faker::Config.locale='fr'
Faker::UniqueGenerator.clear
require 'bcrypt'

puts '_____SEEDING_____'
Attendance.destroy_all
User.destroy_all
Event.destroy_all
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
puts '---- reset tables ---'

10.times do |i|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Lorem.unique.characters(number: rand(4..10))+"@yopmail.com",
    description: Faker::Lorem.paragraph(sentence_count: rand(2..5))
  )
end
puts '---- 10 users ---'
