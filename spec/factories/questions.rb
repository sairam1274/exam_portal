# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    technology_id 1
    topic_id 1
    title "MyText"
    question_type "MyString"
    parent_id 1
    note "MyText"
    description "MyString"
  end
end
