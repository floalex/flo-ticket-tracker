# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Remember to update id
# SELECT setval('videos_id_seq', (SELECT MAX(id) from "videos")); in psql
user = User.find_or_create_by(name: "John", email: "john@example.com") {|user| user.password = "password"}
puts user.id
user2 = User.find_or_create_by(name: "Joe", email: "joe@example.com") {|user| user.password = "password"}
puts user2.id

rail_tag = Tag.find_or_create_by!(name: "Rail")
critical_tag = Tag.find_or_create_by!(name: "Critical")
cnr_tag = Tag.find_or_create_by!(name: "Could Not Reproduce")
needs_info_tag = Tag.find_or_create_by!(name: "Needs Info")
out_of_scope_tag = Tag.find_or_create_by!(name: "Out of Scope")

project = Project.find_or_create_by!(name: "Danyang–Kunshan Grand Bridge",
                          description: "The Danyang–Kunshan Grand Bridge is the world's longest bridge.[2] It is a 164.8-kilometre (102.4 mi) long viaduct on the Beijing–Shanghai High-Speed Railway.")

ticket1 = project.tickets.find_or_create_by!(name: "Shaky section 6 miles from North end.",
                                 body: "Reported by a rail passenger.",
                                 creator: user2,
                                 assignee: user) {|ticket| ticket.tags = [rail_tag, critical_tag] }

ticket1.comments.find_or_create_by!(body: "This seems serious.", creator: user)

ticket2 = project.tickets.find_or_create_by!(name: "Trains late getting to Wuxi East",
                                 body: "Train was at least 5 minutes late today",
                                 creator: user2,
                                 status: "fixed") {|ticket| ticket.tags = [rail_tag, out_of_scope_tag] }

ticket2.comments.find_or_create_by!(body: "This is not a problem with the bridge", creator: user)

ticket3 = project.tickets.find_or_create_by!(name: "Track is not connected in the middle",
                                 body: "This is preventing the entire system from working.",
                                 creator: user2,
                                 status: "blocked") {|ticket| ticket.tags = [rail_tag, needs_info_tag, cnr_tag] }

ticket3.comments.find_or_create_by!(body: "I have been unable to observe this myself.", creator: user)