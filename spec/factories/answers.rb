# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    user_id 1
    technology_id 1
    topic_id 1
    is_correct false
    question_type "MyString"
    question_id 1
    question_title "MyString"
     "MyString"
    actual_answer_ids "MyString"
     "MyString"
    given_answer_ids "MyString"
    actual_answers "MyText"
    given_answers "MyText"
    free_text_answer "MyText"
  end
end
