class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  
  def vote
    @submission = Submission.find(params[:id])
    begin
      User.find(params[:reply][:user_id]).vote_for(@submission)
    rescue Exception
      # lmao who cares
    end
    redirect_to request.referer
  end
  
  def user_submissions
    begin
      @user = User.find(params[:user])
      @submissions = Submission.where("user_id=?", params[:user]).order("created_at DESC")
    rescue ActiveRecord::RecordNotFound
      render :json => { "status" => "404", "error" => "User not found."}, status: :not_found
    end
  end

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all.order("created_at DESC")
  end
  
  # GET /submissions/ask
  # GET /submissions/ask.json
  def ask
    @submissions = Submission.all.order("created_at DESC")
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @comments = Comment.where("submission_id=" + (params[:id])).order("created_at DESC")
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    parameters = submission_params
    if !submission_params[:url].start_with?('http')
      parameters[:url] = 'http://' + submission_params[:url]
    end
    @submission = Submission.new(parameters)

    respond_to do |format|
      if @submission.save
        current_user&.vote_for(@submission)
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:title, :url, :text, :user_id)
    end
end
