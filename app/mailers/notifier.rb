class Notifier < ActionMailer::Base
  default :from => "noreply@synechron.com"
 

  def exam_submit_mail(exam,user)
      @exam = exam
      @user = user
      @topic = Topic.find(@exam.topic_id)
      subject = "#{@user.name} has given exam on #{@topic.name.capitalize}."
      mail(:to => "margesh.sonawane@synechron.com",
           :subject => subject)
  end


 def exam_complete_mail(exam)
      @exam = exam
      @user = User.find(@exam.user_id)
      @topic = Topic.find(@exam.topic_id)
      subject = "Results of exam given on #{@topic.name.capitalize}."
      mail(:to => @user.email,
           :subject => subject)
  end


  

  
end
