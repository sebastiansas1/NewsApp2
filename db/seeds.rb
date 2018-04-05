# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include ApiHelper

Reader.create!([{ id: 1, email: "lorena@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Lorena" },
                   { id: 2, email: "mike@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Mike" }])

Admin.create!( id: 1, email: "sebastiansasbusiness@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Sebastian" )

p "Created #{Category.count} things"

