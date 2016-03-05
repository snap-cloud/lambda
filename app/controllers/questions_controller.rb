class QuestionsController < ApplicationController
  include DceLti

  # TODO: extract this.
  require 'canvas-api'

  before_action :set_question, only: [
    :show, :edit, :update, :destroy,
    :starter_file, :submit_grade, :test_file
  ]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    if @question.starter_file
      gon.starter_file_path = starter_file_question_path
    else
      gon.starter_file_path = nil # TODO -- does this work?
    end
    gon.submissions_path = submission_question_path
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html {
          redirect_to @question,
          notice: 'question was successfully created.'
        }
        format.json {
          render :show, status: :created, location: @question
        }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html {
          redirect_to @question,
          notice: 'question was successfully updated.'
        }
        format.json {
          render :show, status: :ok, location: @question
        }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # LIT Submit grade
  # POST /questions/1/submission
  def submit_grade
    puts 'CALLED SUBMIT GRADE'

    @provider ||= get_tool_provider
    score = normalize_score(params[:score], @question.points)

    # TODO: Extra to user logging function.
    if @provider.nil?
      user_json = {}
    else
      cParams = @provider.custom_params
      user_json = {
        canvas_id: cParams["canvas_user_id"],
        full_name: @provider.lis_person_name_full,
        canvas_login_id: cParams["canvas_user_login_id"]
      }
    end
    Submission.create(
      question_id: @question.id,
      score: score,
      code_submission: params[:code_submission],
      test_results: params[:test_results],
      user_info: user_json,
      session_id: session.id
    )

    if @provider.nil?
      puts 'Saved submission log for non-lti context'
      render nothing: true
      return
    end
     puts '='*50

     if @provider.outcome_service?
       previos = get_previous_score(@provider)
       if previous == nil || score > previous
         # do submit
       else
         puts 'Found previous score, no need to resubmit.'
         redirect_to '/', flash[:success] => 'Posted a grade...sorta'
       end
       begin
         puts 'Trying to submit grade'
         response = @provider.post_replace_result!(score)
         if response.success?
           puts 'PARTY'
           # grade write worked
         elsif response.processing?
           puts 'Processing....'
         elsif response.unsupported?
           puts 'Unsupported'
         else
           puts 'ERROR: LTI Response'
           puts response.message_identifier
           puts response.message_ref_identifier
           puts response.severity
           puts 'USER JSON'
           puts user_json
           do_submit_api_grade(score)
         end
       rescue Exception => e
         puts e.message
         puts e.backtrace.inspect
         do_submit_api_grade(score)
       end
     else
       puts 'NO SUBMIT GRADE'
       # normal tool launch without grade write-back
     end
     render nothing: true
   end

   # Return the starter file as XML.
   # GET /questions/1/starter-file
  def starter_file
    render xml: @question.starter_file
  end

  # Return the tests JS file as text.
  # GET /questions/1/test-file
  def test_file
    render text: @question.test_file
  end

  def do_submit_api_grade(score)
    if @provider.tool_consumer_info_product_family_code != "canvas"
      puts 'Non Canvas Request Found'
      return
    end
    puts 'TRYING CANVAS API'
    cParams = @provider.custom_params
    canvas = Canvas::API.new(
      :host => "https://bcourses.berkeley.edu",
      :token => ENV['CANVAS_API_TOKEN']
    )
    url = "/api/v1/courses/"
    url = url + "#{cParams['canvas_course_id']}/assignments/#{cParams['canvas_assignment_id']}/submissions/#{cParams['canvas_user_id']}/"
    resp = canvas.post(url, {
      'submission[posted_grade]' => score,
      'submission[submission_type]' => 'online_text_entry'
      } )
    puts 'posted score via canvas API.'
    puts resp
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # white list allowed parameters.
    def question_params
      params.require(:question).permit(:title, :points, :content, :starter_file, :test_file, :metadata)
    end

    # LTI requires scores to be returned as a float, that's a percentage.
    # We will "normalize" values >1 to be a % of the question's score
    # Note that a 1/x would be treated as a 100%
    def normalize_score(score, max_points)
      score = score.to_f
      max_points = max_points.to_f
      if score >= 0.0 and score <= 1.0
        score.to_s
      else
        (score / max_points).to_s
      end
    end
end
