# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role::AVAILABLE_ROLES.each do |name|
    Role.create!(name: name)
end

3.times do
  User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "password",
      country: Faker::Address.country,
      occupation: "farmer")
end
users = User.all

users.each do |f|
  f.add_role :regular
end

admin = User.create!(first_name: "admin", last_name: "adminowski", email: "admin@admin.com",
                    password: "adminadmin", occupation: "admin", country: "Polska" )
admin.add_role :admin

10.times do
  Project.create!(
             name: Faker::Lorem.word,
             description: Faker::Lorem.sentence,
             goal: Faker::Number.number(6),
             current_funds: 0,
             setup_date: Faker::Time.between(DateTime.now, 2.day.from_now),
             finish_date: Faker::Time.between(3.days.from_now, 5.days.from_now),
             owner_id: users.sample.id,
             status: 0
  )
end
projects = Project.all

20.times do
  Payment.create!(
             value: Faker::Number.between(1,1000),
             project_id: projects.sample.id,
             user_id: users.sample.id
  )
end


# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
