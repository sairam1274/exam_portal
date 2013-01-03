# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    user_id 1
    technology_id 1
    topic_id 1
    start_time "2013-01-03 15:02:21"
    end_time "2013-01-03 15:02:21"
  end
end
