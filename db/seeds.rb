# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Skill.destroy_all

Skill.create name: 'Java', context: 'Language'
Skill.create name: 'Scala', context: 'Language'
Skill.create name: 'C', context: 'Language'
Skill.create name: 'C++', context: 'Language'
Skill.create name: 'Ruby', context: 'Language'
Skill.create name: 'Rails', context: 'Framework'
Skill.create name: 'Node.js', context: 'Framework'
Skill.create name: 'Play', context: 'Framework'
Skill.create name: 'Dropwizard', context: 'Framework'
Skill.create name: 'Vert.x', context: 'Framework'


Team.destroy_all

Team.create name: 'Test team 1'
Team.create name: 'Test team 2'
