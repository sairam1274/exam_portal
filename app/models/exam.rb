class Exam < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :technology_id, :topic_id, :user_id
  has_many :answers
  belongs_to :user
end
