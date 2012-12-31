# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    question_id 1
    answer "MyText"
    answer_type "MyString"
    correct_answer false
  end
end
