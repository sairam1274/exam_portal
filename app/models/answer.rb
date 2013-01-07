class Answer < ActiveRecord::Base
  serialize :actual_answers
  serialize :given_answers
  
  attr_accessible :actual_answer_ids, :actual_answers, :free_text_answer, :given_answer_ids, :given_answers, :is_correct, :question_id, :question_title, :question_type, :technology_id, :topic_id, :user_id, :exam_id
  belongs_to :exam

  

end
