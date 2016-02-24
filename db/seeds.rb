# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = [
  'MOOC 3 GPS',
  'MOOC 3 Spam Ham',
  'MOOC 3 Subsets'
]


questions.each do |title|
  Question.create(
    title: title,
    content: 'mooc imported question',
    points: 2,
    starter_file: File.read("db/seed-data/#{title}.xml"),
    test_file: File.read("db/seed-data/#{title}.js"),
    metadata: {}
  )
end