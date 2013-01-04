class HomeController < ApplicationController
  def index
    @technologies = Technology.all
  end


  def exam

    @topic = Topic.find_by_id(params[:id])
    respond_to do |format|
      unless @topic.blank?
        unless @topic.questions.blank?
          @exam = Exam.create(:topic_id=>@topic.id,:technology_id=>@topic.technology_id,:user_id=>current_user.id,:start_time=>Time.now)
        end
        format.html
      else
        flash[:notice] = "Oops, we don't have questions on this topic right now.Please try another."
        format.js { render :js => "window.location.replace('#{root_url}');"  }
      end
    end
  end

  def save_exam
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic
        @exam = Exam.find_by_id(params[:answer][:exam_id])
        unless @topic.questions.blank?
          @topic.questions.each_with_index do |question,i|
            @answer = Answer.first(:conditions => {:exam_id => @exam.id, :topic_id =>@topic.id, :question_id => question.id})
            if @answer.blank?
              @answer = Answer.new()
              @answer.exam_id = @exam.id
              @answer.question_id = question.id
              @answer.question_title = question.title
              @answer.topic_id = @topic.id
              @answer.technology_id = @topic.technology_id
              @answer.user_id = current_user.id
              @answer.question_type = question.question_type
              @answer_ids = params[:answer]["#{question.id}"].collect{|c| c} unless params[:answer]["#{question.id}"].blank?
              p @answer_ids
              if question.question_type == "single"
                @answer.actual_answer_ids = question.options.collect{|c| c.id if c.correct_answer == true}.compact.join(',') unless question.options.blank?
                @answer.given_answer_ids = @answer_ids.join(',') unless params[:answer]["#{question.id}"].blank?
                @answer.actual_answers = question.options.collect{|c| c.answer} unless question.options.blank?
                @answer.given_answers =  params[:answer]["#{question.id}_#{question.topic_id}"] unless params[:answer]["#{question.id}_#{question.topic_id}"].blank?
              elsif question.question_type == "multiple"
                @answer.actual_answer_ids = question.options.collect{|c| c.id if c.correct_answer == true}.compact.join(',') unless question.options.blank?
                @answer.given_answer_ids = @answer_ids.join(',') unless params[:answer]["#{question.id}"].blank?
                @answer.actual_answers = question.options.collect{|c| c.answer} unless question.options.blank?
                @answer.given_answers =  params[:answer]["#{question.id}_#{question.topic_id}"] unless params[:answer]["#{question.id}_#{question.topic_id}"].blank?
              elsif question.question_type == "free_text"
                #@answer.given_answers =  params[:answer]["#{question.id}"] unless params[:answer]["#{question.id}"].blank?
                @answer.free_text_answer =  params[:answer]["#{question.id}"] unless params[:answer]["#{question.id}"].blank?

              end
              @answer.save!
            end
            if @answer.question_type != "free_text"
              unless @answer.given_answer_ids.blank?
                if @answer.given_answer_ids == @answer.actual_answer_ids
                  @answer.update_attributes(:is_correct=>true)
                end
              end
            end
          end
          @exam.update_attributes(:end_time=>Time.now)
          @multiple_choice_questions = @exam.answers.where(['question_type <> ?', "free_text"]).length
          if @multiple_choice_questions > 0
            @correct_multiple_choice_questions = @exam.answers.where(['is_correct =? and question_type <> ?',true, "free_text"]).length
          end
          @free_text_questions = @exam.answers.where(['question_type = ?', "free_text"]).length
        end
        if (@multiple_choice_questions > 0 and @free_text_questions > 0)
          flash[:notice] = "Thanks.You got #{@correct_multiple_choice_questions} out of #{@multiple_choice_questions} questions right for other #{@free_text_questions} - we shall update you in 2 days and add it to your final score."
        elsif (@multiple_choice_questions == 0 and @free_text_questions > 0)
          flash[:notice] = "Thanks. For #{@free_text_questions} text question - we shall update you in 2 days and add it to your final score."
        elsif (@multiple_choice_questions > 0 and @free_text_questions == 0)
          flash[:notice] = "Thanks.You got #{@correct_multiple_choice_questions} out of #{@multiple_choice_questions} questions right and it is to your final score."
        end
        format.js { render :js => "window.location.replace('#{show_reports_url(@exam.id)}');" }
      else
        html = render_to_string(:partial => "home/exam_form")
        format.js { render :json => { :html => html } }
      end
    end
  end

end
