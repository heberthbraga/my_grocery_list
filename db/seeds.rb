# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creates default Roles

api_role = Role.find_by(name: Role.api)

if api_role.nil?
  puts "Create API Role"
  role = Role.new
  role.name = Role.api
  role.position = 0
  role.save!
end

