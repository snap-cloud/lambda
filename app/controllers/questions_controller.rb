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
    #@question = question.find(params[:question_id])
    @provider ||= get_tool_provider
    if @provider.nil?
       redirect_to '/', flash[:error] => 'Can\'t post grades if no LTI'
       return
     end

     puts '='*72
     puts 'Submission'
     debugger
     if @provider.outcome_service?
       begin
         puts 'Trying to submit grade'
         score = normalize_score(params[:score], @question.points)
         response = @provider.post_replace_result!(score)
         # TODO: CHECK FOR HIGHEST SCORE
        if response.success?
          puts 'PARTYYYYYYYYYY'
          # grade write worked
        elsif response.processing?
          puts 'Processing....'
        elsif response.unsupported?
          puts 'Unsupported'
        else
          puts 'sadface.'
          do_submit_api_grade(score)
          # debugger
          # failed
        end
      rescue
        do_submit_api_grade(score)
      end
    else
      puts 'NO SUBMIT GRADE'
      # normal tool launch without grade write-back
    end
    redirect_to '/', flash[:success] => 'Posted a grade...sorta'
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
    puts 'BAD LTI ERROR'
    puts 'TRYING CANVAS API'
    cParams = @provider.custom_params
    canvas = Canvas::API.new(
      :host => "https://#{cParams['canvas_api_domain']}",
      :token => ENV['CANVAS_API_TOKEN']
    )
    url = "/api/v1/courses/"
    url = url + "#{cParams['canvas_course_id']}/assignments/#{cParams['canvas_assignment_id']}/submissions/#{cParams['canvas_user_id']}"
    canvas.put(url, {'submission[posted_grade]' => score} )
    puts 'posted score via canvas API.'
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
