FactoryGirl.define do  factory :submission do
    question_id 1
score 1.5
code_submission "MyString"
test_results "MyString"
user_info ""
session_id 1
  end

  factory :question do
    title "MyString"
    points 1.5
    content "MyText"
    tests "MyText"
    initial_file "MyText"
    metadata "MyText"
    tags "MyText"
  end
end
