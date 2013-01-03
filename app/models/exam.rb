class Exam < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :technology_id, :topic_id, :user_id
end
