require 'csv'
# Must be run from app directory.
SEEDS_DIRECTORY = Rails.root.join('public', 'autograder')

DATA_FILE = 'question_list.csv'

questions = CSV.read("#{SEEDS_DIRECTORY}/#{DATA_FILE}")

# Reference row 1:
# ["Unit", "Curriculum (Page Heading)", "Title of Problem",
#  "Github Link to File", "Starter File Name"]

questions.delete_at(0)

def title(question)
  "U#{question[0]} - #{question[1]} - #{question[2]}"
end

questions.each do |question|
  starter = question[4] ? File.read("#{SEEDS_DIRECTORY}/#{question[4]}") : nil
  tests = question[3] ? File.read("#{SEEDS_DIRECTORY}/#{question[3]}") : nil
  if !tests
    puts "ERROR: Tests missing for #{title(question)}"
  end

  Question.create!(
    title: title(question),
    points: 2.0, # TODO - fix this.
    content: question.to_s,
    metadata: {},
    test_file: tests,
    starter_file: starter
  )
  puts "Created #{title(question)}"
end

puts "Created #{questions.length} questions."
