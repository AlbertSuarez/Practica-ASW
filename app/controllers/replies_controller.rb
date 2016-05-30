class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  
  def vote
    @reply = Reply.find(params[:id])
    auth_user = current_user
    begin
      tmp = User.where("oauth_token=?", request.headers["HTTP_API_KEY"])[0]
      if (tmp)
        auth_user = tmp
      end
    rescue
      # intentionally left out
    end
    begin
      auth_user.vote_for(@reply)
    rescue
      # ok
    end
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.json { render :json => @reply }
    end
  end
  
  def votes
    thing = Reply.find(params[:id])
    auth_user = current_user
    begin
      tmp = User.where("oauth_token=?", request.headers["HTTP_API_KEY"])[0]
      if (tmp)
        auth_user = tmp
      end
    rescue
      # intentionally left out
    end
    if (auth_user)
      render :json => { "votes" => thing.votes.size, "voted" => auth_user.voted_for?(thing)}, status: :not_found
      return;
    else
      render :json => { "votes" => thing.votes.size, "voted" => false}, status: :not_found
      return;
    end
  end

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    
    auth_user = current_user
    begin
      tmp = User.where("oauth_token=?", request.headers["HTTP_API_KEY"])[0]
      if (tmp)
        auth_user = tmp
      end
    rescue
      # intentionally left out
    end
    
    if auth_user
      @reply = Reply.new(reply_params)
      @reply.user = auth_user
      
  
       respond_to do |format|
        if @reply.save
           current_user&.vote_for(@reply)
           format.html { redirect_to @reply.comment.submission, notice: 'Reply was successfully created.' }
           format.json { render :show, status: :created, location: @reply }
        else
          format.html { redirect_to '/comments/' + (@reply.comment.id).to_s + '/new_reply', notice: 'Reply not created, you have to fill de field content' }
          format.json { render json: @reply.errors, status: :unprocessable_entity }
        end
       end
    else
      redirect_to "/auth/google_oauth2"
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def comment_replies
    begin
      @replies = Reply.where("comment_id=?", params[:id]).order("created_at DESC")
    rescue ActiveRecord::RecordNotFound
      render :json => { "code" => "404", "message" => "Comment not found."}, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content, :user_id, :comment_id)
    end
end
