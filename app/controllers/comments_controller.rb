class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  def vote
    @comment = Comment.find(params[:id])
    begin
      User.find(params[:reply][:user_id]).vote_for(@comment)
    rescue Exception
      # lmao who cares
    end
    redirect_to request.referer
  end
  
  def new_reply
    @comment = Comment.find(params[:id])
    @replies = Reply.where("comment_id=?",@comment.id).order("created_at DESC")
  end
  
  def threads
    @commentsandreplies = Comment.all.order("created_at DESC") | Reply.all.order("created_at DESC")
  end
  
  def user_comments
    @user = User.find(params[:user])
    @comments = Comment.all.order("created_at DESC")
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    
    if current_user
      @comment = Comment.new(comment_params)
      
      current_user.vote_for(@comment)
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment.submission, notice: 'Comment was successfully created.' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to @comment.submission, notice: 'Comment not created, you have to fill de field content' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/auth/google_oauth2"
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.submission, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :submission_id)
    end
end
