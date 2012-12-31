class Option < ActiveRecord::Base
  attr_accessible :answer, :answer_type, :correct_answer, :question_id

  belongs_to :question

  #validates :answer, :presence => true
end
