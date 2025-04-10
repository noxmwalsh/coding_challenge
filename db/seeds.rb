require 'faker'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a test user if it doesn't exist
test_user = User.find_or_create_by!(email: 'test@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end

# Generate 20 random dog-related posts
20.times do |i|
  title = [
    "#{Faker::Creature::Dog.breed} Training Guide",
    "Living with a #{Faker::Creature::Dog.breed}",
    "Health Tips for Your #{Faker::Creature::Dog.breed}",
    "Why #{Faker::Creature::Dog.breed}s Make Great Pets",
    "#{Faker::Creature::Dog.breed} Care and Maintenance"
  ].sample

  description = [
    "Everything you need to know about #{Faker::Creature::Dog.breed}s",
    "Essential tips for #{Faker::Creature::Dog.breed} owners",
    "A complete guide to raising a #{Faker::Creature::Dog.breed}",
    "Understanding your #{Faker::Creature::Dog.breed}'s needs",
    "Expert advice on #{Faker::Creature::Dog.breed} care"
  ].sample

  body = []
  5.times do
    paragraph = []
    3.times do
      paragraph << [
        "Your #{Faker::Creature::Dog.breed} #{Faker::Creature::Dog.sound} #{Faker::Creature::Dog.age}.",
        "The #{Faker::Creature::Dog.breed} is known for being #{Faker::Creature::Dog.meme_phrase}.",
        "A healthy #{Faker::Creature::Dog.breed} needs regular #{Faker::Creature::Dog.coat_length} coat maintenance.",
        "#{Faker::Creature::Dog.breed}s are excellent at #{Faker::Verb.ing_form} and #{Faker::Verb.ing_form}.",
        "Consider adopting a #{Faker::Creature::Dog.breed} from your local shelter."
      ].sample
    end
    body << paragraph.join(" ")
  end

  Post.find_or_create_by!(title: title) do |post|
    post.description = description
    post.body = body.join("\n\n")
    post.author = test_user.email
    post.user = test_user
  end
end

puts "Created #{User.count} users and #{Post.count} posts"
