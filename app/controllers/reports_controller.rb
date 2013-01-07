class ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_user, :only => [:index]
   
  def index
    @exams = Kaminari.paginate_array(Exam.where(["end_time is NOT NULL"]).order("created_at desc")).page(params[:page]).per(9)
  end


  def show
    @exam = Exam.first(:conditions => {:id => params[:id], :user_id => current_user.id})
    unless @exam.blank?
      @topic = Topic.find_by_id(@exam.topic_id)
    else
      flash[:notice] = "We don't have report for this exam right now."
      redirect_to root_url
    end
  end

  def my_reports
     @exams = Kaminari.paginate_array(Exam.where(["end_time is NOT NULL and user_id =?",current_user.id]).order("created_at desc")).page(params[:page]).per(9)
     render :action => "index"
  end

end
