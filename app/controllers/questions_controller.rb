class QuestionsController < ApplicationController
  include DceLti

  # TODO: extract this.
  require 'canvas-api'

  before_action :set_question, only: [
    :show, :edit, :update, :destroy,
    :starter_file, :submit_grade, :test_file
  ]

  before_action :require_admin, only: [
    :edit, :update, :destroy, :new
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
      gon.starter_file_path = nil
    end
    gon.submissions_path = submission_question_path
    render layout: 'base'
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
          notice: "Question #{@question.title} was successfully created."
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
          notice: "Question #{@question.title} was successfully updated."
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
      format.html {
        redirect_to(questions_url,
                    notice: 'question was successfully destroyed.')
      }
      format.json { head :no_content }
    end
  end

  # LIT Submit grade
  # POST /questions/1/submission
  # TODO: Move to a submission model
  def submit_grade
    @provider ||= get_tool_provider
    score = normalize_score(params[:score], @question.points)

    # TODO: Extra to user logging function.
    if @provider.nil?
      dce_lti_id = nil
      user_json = {}
    else
      cParams = @provider.custom_params
      dce_lti_id = @provider.user_id
      # TODO: Store the email...
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
      session_id: session.id,
      user_id: current_user.nil? ?  nil : current_user.id,
      dce_lti_user_id: dce_lti_id
    )

    # TODO: Extract this conditional info a function
    if !@provider.nil? && @provider.outcome_service?
      previous = get_previous_score(@provider)
      if previous != nil || score <= previous
        puts 'Found previous score, no need to resubmit.'
        render nothing: true
        return
      end
      begin
        puts 'Trying to submit grade'
        response = @provider.post_replace_result!(score)
        if response.success?
          puts 'PARTY' # grade write worked
        elsif response.processing?
          puts 'Processing....'
        elsif response.unsupported?
          puts 'Unsupported'
        else
          puts 'ERROR: LTI Response'
          puts response.message_identifier
          puts response.description
          puts response.code_major
          do_submit_api_grade(score)
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
        do_submit_api_grade(score)
      end
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
    render(text: @question.test_file)
  end

  # TODO: Move this to a separate file.
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
    url = "#{url}#{cParams['canvas_course_id']}/assignments/#{cParams['canvas_assignment_id']}/submissions/#{cParams['canvas_user_id']}"
    resp = canvas.put(url,  "submission[posted_grade]=#{score.to_f * 100}%"  )
    puts 'posted score via canvas API.'
    puts resp
  end

  # Make an LTI call that tries to return the previous score.
  def get_previous_score(provider)
    score = nil
    begin
      response = provider.post_read_result!
      if response.success?
        puts "Got previous score #{response.score}"
        score = response.score
      else
        puts 'Unable to get Previous score'
      end
    rescue Exception => e
      puts 'EXCEPTION IN GETTING PREVIOUS SCORE'
      puts e.message
      puts e.backtrace.inspect
    end
    score
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
