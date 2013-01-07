class Exam < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :technology_id, :topic_id, :user_id, :is_completed, :marks
  has_many :answers
  belongs_to :user
end
