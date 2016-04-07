# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(username:  "ExampleUser",
             email: "exampleuser@social-wiki.org",
             email_confirmation: "exampleuser@social-wiki.org",
             password:              "foobar11",
             password_confirmation: "foobar11",
             activated: true,
             activated_at: Time.zone.now)

10.times do |n|
  name  = "exampleu#{n+1}"
  email = "example-#{n+1}@social-wiki.org"
  password = "password11"
  User.create!(username:  name,
              email: email,
              email_confirmation: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end