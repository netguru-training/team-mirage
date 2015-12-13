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
    occupation: "farmer"
  )
end
users = User.all

users.each do |f|
  f.add_role :regular
end

admin = User.first_or_create!(
  first_name: "admin",
  last_name: "adminowski",
  email: "admin@admin.com",
  password: "adminadmin",
  occupation: "admin",
  country: "Polska"
)
admin.add_role :admin

10.times do
  Project.create!(
    name: Faker::Lorem.word,
    description: Faker::Lorem.sentence,
    goal: Faker::Number.number(4),
    current_funds: 0,
    setup_date: Faker::Time.between(DateTime.now, 2.day.from_now),
    finish_date: Faker::Time.between(3.days.from_now, 5.days.from_now),
    owner_id: users.sample.id,
    status: 0
  )
end

projects = Project.all

projects.each do |p|
  p.update(created_at: Faker::Time.between(DateTime.now - 5.years, 2.day.from_now))
end

200.times do
  Payment.create!(
    value: Faker::Number.between(1,1000),
    project_id: projects.sample.id,
    user_id: users.sample.id,
    created_at: Faker::Time.between(14.days.ago, 3.days.ago)
  )
end

projects.each do |project|
  rand(5).times do
    project.comments.create!(
      body: Faker::Lorem.paragraph,
      user: User.all.sample
    )
  end
end

projects.first.waiting!

succeeded_project = projects.second
succeeded_project.current_funds = succeeded_project.goal * 1.5
succeeded_project.succeed!
succeeded_project.ratings.create(
  value: rand(10) + 1,
  user: succeeded_project.payments.first.user
)

projects.third.current_funds = projects.third.goal / 2
projects.third.failed!
