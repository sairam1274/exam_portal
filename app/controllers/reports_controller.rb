class ReportsController < ApplicationController
   before_filter :authenticate_user!

   def show
     @exam = Exam.first(:conditions => {:id => params[:id], :user_id => current_user.id})
     unless @exam.blank?
       @topic = Topic.find_by_id(@exam.topic_id)
       


     else
       flash[:notice] = "We don't have report for this exam right now."
       redirect_to root_url
     end
   end

end
