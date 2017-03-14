class SubmissionsController < ApplicationController

  # GET /submissions/1
  def show
    set_submission
    # TODO: better not found path.
    redirect_to '/404' and return unless user_can_view?

    render xml: @submission.code_submission
  end

  # GET /submissions
  # GET /submissions.json
  # def index
  # end

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

  def user_can_view?
    return false unless current_user
    return true if current_user.admin?
    @submission.user_id == current_user.id ||
      @submission.dce_lti_user_id == current_user.id
  end

  def submission_params
    params.require(:submission).permit(:code_submission, :question, :user)
  end
end