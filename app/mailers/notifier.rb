class Notifier < ActionMailer::Base
  default :from => "noreply@synechron.com"
 

  def exam_submit_mail(exam,user)
      @exam = exam
      @user = user
      subject = "this is test"
      mail(:to => "margesh.sonawane@synechron.com",
           :subject => subject)
  end

  
end
