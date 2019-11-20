class SubmissionsController < ApplicationController

  before_filter :set_question

  # GET /submissions/1
  def show
    set_submission
    redirect_to '/404' and return unless user_can_view?

    render xml: @submission.code_submission
  end

  # GET /submissions
  # GET /submissions.json
  def index
    redirect_to '/404' and return unless user_can_view_all_submissions?
    @submissions = @question.submissions
  end

  # GET /submissions/new
  # def new
  # end

  # GET /submissions/1/edit
  # def edit
  # end

  # POST /submissions
  # POST /submissions.json
  # def create
  # end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  # def update
  # end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  # def destroy
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def user_can_view?
    return false unless current_user
    return true if current_user.admin?
    @submission.user_id == current_user.id ||
      @submission.dce_lti_user_id == current_user.id
  end

  def user_can_view_all_submissions?
    return false unless current_user
    return true if current_user.admin?
    false
  end

  def submission_params
    params.require(:submission).permit(:code_submission, :question, :user)
  end
end
