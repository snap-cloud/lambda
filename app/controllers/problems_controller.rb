class ProblemsController < ApplicationController
  include DceLti
  # before_filter :authenticate_via_lti
  before_action :set_problem, only: [
    :show, :edit, :update, :destroy,
    :starter_file, :submit_grade, :test_file
  ]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    # TODO: This will need to be more generic.
    # TODO: Refactor if/else's to be functions.
    if @problem.initial_file
      gon.starter_file_path = starter_file_problem_path
    else
      gon.starter_file_path = nil # TODO -- does this work?
    end
    gon.submissions_path = submission_problem_path
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # LIT Submit grade
  # Should probably be done as a POST
  def submit_grade
    #@problem = Problem.find(params[:problem_id])
    @provider ||= get_tool_provider
    if @provider.nil?
       redirect_to '/', flash[:error] => 'Can\'t post grades if no LTI'
       return
     end

    if @provider.outcome_service?
      score = normalize_score(params[:score], @problem.points)
      response = @provider.post_replace_result!(score)
      if response.success?
        puts 'PARTYYYYYYYYYY'
        # grade write worked
      elsif response.processing?
        puts 'Processing....'
      elsif response.unsupported?
        puts 'Unsupported'
      else
        puts 'sadface.'
        # debugger
        # failed
      end
    else
      puts 'NO SUBMIT GRADE'
      # normal tool launch without grade write-back
    end
    redirect_to '/', flash[:success] => 'Posted a grade...sorta'
  end

  # Return the starter file as XML.
  # GET /problems/1/starter-file
  def starter_file
    render xml: @problem.initial_file
  end

  # Return the tests JS file as text.
  # GET /problems/1/test-file
  def test_file
    render text: @problem.tests
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # white list allowed parameters.
    def problem_params
      params.require(:problem).permit(:title, :points, :content, :tests, :initial_file, :metadata, :tags)
    end

    # LTI requires scores to be returned as a float, that's a percentage.
    # We will "normalize" values >1 to be a % of the problem's score
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
